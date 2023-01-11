#!/bin/bash
[[ $EUID -ne 0 ]] && { echo "Run script as root"; exit; }
[[ $# -eq 0 ]] && { echo "Add argument with the file with list of students"; exit;}
[[ -d "$1" || ! -f "$1" ]] && { echo "$1 is not file"; exit;} 
echo "Initializing..."
# groups reading
group_list=$(cut -f3 -d ' ' < "$1" | sort | uniq)
[[ -z "$group_list" ]] && exit # check for no groups in file
# stundents reading
student_list=$(cat "$1")
# reading limits of UIDs for user
UID_MIN="$(read -d '' <'/etc/login.defs'; [[ "${REPLY}" =~ UID_MIN[[:space:]]+([[:digit:]]+)  ]]; echo -n "${BASH_REMATCH[1]}")";
UID_MAX="$(read -d '' <'/etc/login.defs'; [[ "${REPLY}" =~ UID_MAX[[:space:]]+([[:digit:]]+)  ]]; echo -n "${BASH_REMATCH[1]}")";
# declaring variables
group_number=-1
declare -A students
students_group_number=()
echo "Initializing ended"
	 
# script
while true; do
	echo "1. Add all students"
	echo "2. Write all info about students"
	echo "3. Set all students to their groups"
	echo "4. Change students' expiration time and time between changing password"
	echo "8. Print all groups and users"
	echo "9. Remove all students"
	echo "0. Exit"
	printf "%s" "Select mode: "
	read x
	case $x in
		1) 
			if [ ${#students_group_number[@]} -gt 0 ]
			then
				echo "Students already added"
				echo "Removing all students..."
				while read line
				do
					group=$(echo "$line" | cut -f3 -d ' ')
					name_surname=$(echo "$line" | cut -f1-2 -d ' ')
					[[ "$group" != "$current_group" ]] && { counter=1; current_group=$group;} 
					userdel "$group-$counter" 2>/dev/null
					groupdel "$group-$counter" 2>/dev/null
					counter=$(($counter+1))
				done < <( echo "$student_list" | sort -k 3)
				for i in $group_list
				do
					groupdel "$i" 2>/dev/null
				done
				students_group_number=()
				declare -A students
				echo "Ready"
			fi
 
			echo "Adding..."
			while read line
			do
				group=$(echo "$line" | cut -f3 -d ' ')
				name_surname=$(echo "$line" | cut -f1-2 -d ' ')
				password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c10)
				[[ "$group" != "$current_group" ]] && { counter=1;group_number=$(($group_number+1));current_group=$group;} 
				useradd -c "$name_surname" -p "$password" "$current_group-$counter" 2>/dev/null
				students[$group_number,$(($counter-1)),0]=$name_surname
				students[$group_number,$(($counter-1)),1]=$current_group
				students[$group_number,$(($counter-1)),2]=$password
				students_group_number+=("$current_group-$counter $name_surname")
				counter=$(($counter+1))
			done < <( echo "$student_list" | sort -k 3)
			echo "Ready" 
		;;
		2)
			if [[ $group_number -ne -1 ]]
			then
				echo "Writing..."
				for i in $(seq 0 $group_number)
				do
					counter=0
					rm "${students[$i,0,1]}" 2>/dev/null
					touch "${students[$i,0,1]}"
					while [[ ! -z ${students[$i,$counter,0]} ]]
					do
						echo "$(($counter+1))" "${students[$i,$counter,0]}" "${students[$i,$counter,1]}-$(($counter+1))" "${students[$i,$counter,2]}" >> "${students[$i,0,1]}"
						counter=$(($counter+1))
					done
				done
				echo "Ready"
			else
				echo "No added students. Retry attempt"
			fi 
		;;
		3) 
			for i in $group_list
			do
				groupadd -f "$i"
			done
			if [[ $group_number -ne -1 ]]
			then
				echo "Setting..."
				for i in $(seq 0 $group_number)
				do
					counter=0
					while [[ ! -z ${students[$i,$counter,0]} ]]
					do
						usermod -g "${students[$i,0,1]}" "${students[$i,0,1]}-$(($counter+1))" 2>/dev/null
						groupdel "${students[$i,0,1]}-$(($counter+1))" 2>/dev/null
						counter=$(($counter+1))
					done
				done
				echo "Ready"
			else
				echo "No added students. Retry attempt"
			fi 
		;;
		4) 
			if [ ! -z ${#students_group_number[@]} ]
			then
				select i in "${students_group_number[@]}"
				do
					x3="err"
					while ! date --date="$x3" >/dev/null 2>&1
					do
						printf "%s" "Enter expiration date: "
						read x3
					done
					usermod -e "$x3" "$(echo "$i" | cut -f1 -d ' ')"
					x3="err"
					while [[ $x3 != ?(-)+([[:digit:]]) ]]
					do
						printf "%s" "Enter max days to change password: "
						read x3
					done
					chage -M "$x3" "$(echo "$i" | cut -f1 -d ' ')"
					break
				done
			else
				echo "No added students. Retry attempt"
			fi
		;;
		8)
			echo "Groups"
			while read line
			do
				UID_number=$(echo "$line" | cut -f3 -d ':')
				if [[ $UID_MIN -le $UID_number && $UID_number -le $UID_MAX ]]
				then
					echo "$line"
				fi
			done < /etc/group
			echo "Users"
			while read line
			do
				UID_number=$(echo "$line" | cut -f3 -d ':')
				if [[ $UID_MIN -le $UID_number && $UID_number -le $UID_MAX ]]
				then
					echo "$line"
				fi
			done < /etc/passwd
		;;
		9) 
			echo "Removing all students..."
			while read line
			do
				group=$(echo "$line" | cut -f3 -d ' ')
				name_surname=$(echo "$line" | cut -f1-2 -d ' ')
				[[ "$group" != "$current_group" ]] && { counter=1; current_group=$group;} 
				userdel "$group-$counter" 2>/dev/null
				groupdel "$group-$counter" 2>/dev/null
				counter=$(($counter+1))
			done < <( echo "$student_list" | sort -k 3)
			for i in $group_list
			do
				groupdel "$i" 2>/dev/null
			done
			students_group_number=()
			declare -A students
			echo "Ready"
		;;
		*) echo "Exiting.."; exit;;
	esac
done

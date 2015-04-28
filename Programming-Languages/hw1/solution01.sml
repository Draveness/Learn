fun is_older (date1 : (int * int * int), date2 : (int * int * int)) =
    if #1 date1 < #1 date2
    then true
    else if #1 date1 > #1 date2
    then false
    else
	if #2 date1 < #2 date2
        then true
        else if #2 date1 > #2 date2
        then false
        else
            if #3 date1 < #3 date2
            then true
            else false

fun number_in_month (dates : (int * int * int) list, month : int) =
    if null dates
    then 0
    else if #2 (hd dates) = month
    then 1 + number_in_month ((tl dates), month)
    else number_in_month ((tl dates), month)

fun number_in_months (dates: (int * int * int) list, months : int list) =
    if null months
    then 0
    else number_in_month (dates, (hd months)) +
         number_in_months (dates, (tl months))

fun dates_in_month (dates : (int * int * int) list, month : int) =
    if null dates
    then []
    else if #2 (hd dates) = month
    then (hd dates) :: dates_in_month ((tl dates), month)
    else dates_in_month ((tl dates), month)

fun dates_in_months (dates : (int * int * int) list, months : int list) =
    if null months
    then []
    else dates_in_month (dates, (hd months)) @
         dates_in_months (dates, (tl months))

fun get_nth (strings : string list, n : int) =
    if n = 1
    then hd strings
    else get_nth ((tl strings), n - 1)

fun date_to_string (date : (int * int * int)) =
    let val months =  ["January", "February", "March", "April", "May",
		       "June", "July", "August", "September",
		       "October",  "November", "December"]
    in
	get_nth (months, (#2 date)) ^
	" " ^
	Int.toString(#3 date) ^
	", " ^
	Int.toString(#1 date)
    end

fun number_before_reaching_sum (sum : int, xs : int list) =
    let
	fun iter (xs : int list, current : int, count : int) =
	    if current + (hd xs) < sum
	    then iter ((tl xs), current + (hd xs), count + 1)
	    else count
    in
	iter (xs, 0, 0)
    end

fun what_month (day : int) =
    let
	val days_in_months = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
	number_before_reaching_sum (day, days_in_months) + 1
    end

fun month_range (day1 : int, day2 : int) =
    if day1 > day2
    then []
    else what_month (day1) :: month_range (day1 + 1, day2)

fun oldest (dates : (int * int * int) list) =
    if null dates
    then NONE
    else
	let
	    fun oldest_nonempty (dates : (int * int * int) list) =
		if null (tl dates)
		then hd dates
		else
		    let
			val tl_oldest = oldest_nonempty (tl dates)
		    in
			if is_older((hd dates), tl_oldest)
			then hd dates
			else tl_oldest
		    end
	in
	    SOME (oldest_nonempty dates)
	end
fun remove_duplicates(list : int list) =
    let
	fun remove_duplicates_iter(first : int,
				   compare_list : int list,
				   remain_list : int list,
				   result_list : int list) =
	    if null remain_list
	    then [first]
	    else if null compare_list
	    then first :: remove_duplicates_iter ((hd remain_list),
						  (tl remain_list),
						  (tl remain_list),
						  result_list)
	    else if first = hd compare_list
	    then remove_duplicates_iter ((hd remain_list),
					 (tl remain_list),
					 (tl remain_list),
					 result_list)
	    else remove_duplicates_iter (first,
					 (tl compare_list),
					 remain_list,
					 result_list)
    in
	if null list
	then []
	else if null (tl list)
	then list
	else remove_duplicates_iter((hd list),
				    (tl list),
				    (tl list),
				    [])
    end

fun number_in_months_challenge (dates: (int * int * int) list, months : int list) =
    if null months
    then 0
    else number_in_months (dates, remove_duplicates(months))

fun dates_in_months_challenge (dates : (int * int * int) list, months : int list) =
    if null months
    then []
    else dates_in_months (dates, remove_duplicates(months))


fun reasonable_date (date : (int * int * int)) =
    let
	val year  = #1 date
	val month = #2 date
	val day   = #3 date
	val days_in_months = [31,28,31,30,31,30,31,31,30,31,30,31]
	fun isLeapYear (year : int) =
	    (year mod 4 = 0 andalso (not (year mod 100 = 0)))orelse year mod 400 = 0
	fun get_nth (ints : int list, n : int) =
	    if n = 1
	    then hd ints
	    else get_nth ((tl ints), n - 1)
    in
	if year <= 0 orelse month <= 0 orelse month > 12 orelse day <= 0
	then false
	else if isLeapYear(year) andalso month = 2 andalso day < 30
	then true
        else if day <= get_nth(days_in_months, month)
        then true
        else false
    end

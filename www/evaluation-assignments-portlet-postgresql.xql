<?xml version="1.0"?>

<queryset>
<rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="get_grades">      
      <querytext>

		select eg.grade_plural_name,
		eg.grade_id,
		eg.grade_item_id
   	 	from evaluation_gradesx eg, acs_objects ao
		where content_revision__is_live(eg.grade_id) = true
          and eg.item_id = ao.object_id
   		  and ao.context_id in  ([join $list_of_package_ids ,])
		order by grade_plural_name desc
	
      </querytext>
</fullquery>

</queryset>

<?xml version="1.0"?>

<queryset>
<rdbms><type>postgresql</type><version>7.3</version></rdbms>

<fullquery name="get_grades">      
      <querytext>

		select eg.grade_plural_name,
		eg.grade_id,
		eg.grade_item_id
   	 	from evaluation_gradesx eg, acs_objects ao
		where exists (select 1 from cr_items
	            where live_revision = eg.grade_id) 
        	  and eg.item_id = ao.object_id
   		  and ao.context_id in  ([join $list_of_package_ids ,])
		order by grade_plural_name desc
	
      </querytext>
</fullquery>

<fullquery name="get_total_grade">      
      <querytext>

	select evaluation__class_total_grade(:user_id,[lindex $list_of_package_ids 0])
	
      </querytext>
</fullquery>

</queryset>

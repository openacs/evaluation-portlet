<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.3</version></rdbms>

<fullquery name="get_group_id">      
      <querytext>
	select coalesce((select etg2.group_id from evaluation_task_groups etg2, 
                                                      evaluation_tasks et2, 
                                                      acs_rels map 
                                                      where map.object_id_one = etg2.group_id 
                                                        and map.object_id_two = :user_id 
                                                        and etg2.task_item_id = et2.task_item_id 
                                                        and et2.task_id = :task_id),0)
               from evaluation_tasks et3 
              where et3.task_id = :task_id 

--		select evaluation__party_id(:user_id,:task_id)
      </querytext>
</fullquery>

<fullquery name="get_evaluation_info">      
      <querytext>
	    select round(ese.grade,2) as grade,
	    ese.evaluation_id,
	    ese.description as comments,
	    ese.show_student_p,
	    round((ese.grade*:t_weight*:g_weight)/10000,2) as task_grade
	    from evaluation_student_evalsi ese, cr_items cri
	    where ese.task_item_id = :task_item_id
	    and cri.live_revision = ese.evaluation_id
	    and ese.party_id = 
	( select 
	CASE  
	  WHEN et3.number_of_members = 1 THEN :user_id 
	  ELSE  
	(select etg2.group_id from evaluation_task_groups etg2, 
                                                      evaluation_tasks et2, 
                                                      acs_rels map 
                                                      where map.object_id_one = etg2.group_id 
                                                        and map.object_id_two = :user_id 
                                                        and etg2.task_item_id = et2.task_item_id 
                                                        and et2.task_id = :task_id) 
	END as nom 
               from evaluation_tasks et3 
              where et3.task_id = :task_id 
	) 
-- evaluation__party_id(:user_id,:task_id)
      </querytext>
</fullquery>

<fullquery name="get_answer_info">      
      <querytext>
	    select ea.data as answer_data, 
	    ea.title as answer_title, 
	    ea.answer_id 
	    from evaluation_answersi ea, cr_items cri
	    where ea.task_item_id = :task_item_id 
	    and cri.live_revision = ea.answer_id
	    and ea.party_id = 
	( select 
	CASE  
	  WHEN et3.number_of_members = 1 THEN :user_id 
	  ELSE  
	(select etg2.group_id from evaluation_task_groups etg2, 
                                                      evaluation_tasks et2, 
                                                      acs_rels map 
                                                      where map.object_id_one = etg2.group_id 
                                                        and map.object_id_two = :user_id 
                                                        and etg2.task_item_id = et2.task_item_id 
                                                        and et2.task_id = :task_id) 
	END as nom 
               from evaluation_tasks et3 
              where et3.task_id = :task_id 
	) 
-- evaluation__party_id(:user_id,:task_id)
      </querytext>
</fullquery>


</queryset>

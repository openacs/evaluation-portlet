
  <if @shaded_p@ ne "t">
    <ul>
    <li>@notification_chunk;noquote@<br /></li>
    <if @grades:rowcount@ eq 0>
      <li>#evaluation-portlet.lt_There_are_no_tasks_fo#</li>
    </if><else>
       <multiple name="grades">
	 <li><strong>@grades.grade_plural_name@</strong> <br />
	 <include src="../lib/tasks-chunk" grade_id=@grades.grade_id@ grade_item_id=@grades.grade_item_id@ assignments_orderby=@assignments_orderby@ page_num=@page_num@>
         <br /><br />
	 </li>
       </multiple>
    </else>
    </ul>
  </if>
  <else>
  &nbsp;
  </else>



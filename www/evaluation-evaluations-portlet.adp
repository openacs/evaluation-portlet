
  <if @shaded_p@ ne "t">
   <ul>
   <if @admin_p@ eq 1>
      <li><a href="evaluation/admin/grades/grades">#evaluation-portlet.lt_Admin_my_Assignment_T#</a><br /></li>
   </if>
   <li>@notification_chunk;noquote@<br /></li>

    <if @grades:rowcount@ eq 0>
       <li>#evaluation-portlet.lt_There_are_no_tasks_to#</li>
    </if><else>
    <multiple name="grades">
       <li><strong>@grades.grade_plural_name;noquote@</strong> <br />
       <include src="../lib/evaluations-chunk" grade_id=@grades.grade_id@ grade_item_id=@grades.grade_item_id@ evaluations_orderby=@evaluations_orderby@ page_num=@page_num@>
       <br /><br />
       </li>
    </multiple>
    <if @admin_p@ eq "0" and @one_instance_p@ eq "1">
     <br />#evaluation-portlet.lt_Your_total_grade_in_t# <strong>@total_class_grade@/@max_possible_grade@ </strong>
    </if>
    </else>
   </ul>
  </if>
  <else>
  &nbsp;
  </else>



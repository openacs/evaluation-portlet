
  <if @shaded_p@ ne "t">
   <ul>
   <if @admin_p@ eq 1>
      <li><a href="evaluation/admin/grades/grades">Admin my Assignment Types</a><br /></li>
   </if>
   <li>@notification_chunk;noquote@<br /></li>

    <if @grades:rowcount@ eq 0>
       <li>There are no tasks to evaluate for this package.</li>
    </if><else>
    <multiple name="grades">
       <li><strong>@grades.grade_plural_name@</strong> <br />
       <include src="../lib/evaluations-chunk" grade_id=@grades.grade_id@ evaluations_orderby=@evaluations_orderby@>
       </li>
    </multiple>
    <if @admin_p@ eq "0" and @one_instance_p@ eq "1">
     <br />Your total grade in this class is: <strong>@total_class_grade@</strong>
    </if>
    </else>
   </ul>
  </if>
  <else>
  &nbsp;
  </else>


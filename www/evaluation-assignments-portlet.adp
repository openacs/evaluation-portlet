
  <if @shaded_p@ ne "t">
    <ul>
    <li>@notification_chunk;noquote@<br /></li>
    <if @grades:rowcount@ eq 0>
      <li>There are no tasks for this package.</li>
    </if><else>
       <multiple name="grades">
	 <li><strong>@grades.grade_plural_name@</strong> <br />
	 <include src="../lib/tasks-chunk" grade_id=@grades.grade_id@ assignments_orderby=@assignments_orderby@>
	 </li>
       </multiple>
    </else>
    </ul>
  </if>
  <else>
  &nbsp;
  </else>


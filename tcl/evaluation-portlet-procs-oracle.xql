<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="evaluation_assignments_portlet::uninstall.delete_assignments_ds">      
      <querytext>

	select portal_datasource.delete(:ds_id)
    
      </querytext>
</fullquery>

<fullquery name="evaluation_evaluations_portlet::uninstall.delete_evaluations_ds">      
      <querytext>

	select portal_datasource.delete(:ds_id)
    
      </querytext>
</fullquery>

<fullquery name="evaluation_admin_portlet::uninstall.delete_admin_ds">      
      <querytext>

	select portal_datasource.delete(:ds_id)
    
      </querytext>
</fullquery>
 
</queryset>

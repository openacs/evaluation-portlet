<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.3</version></rdbms>

<fullquery name="evaluation_assignments_portlet::uninstall.delete_assignments_ds">      
      <querytext>

	select portal_datasource__delete(:ds_id)
    
      </querytext>
</fullquery>

<fullquery name="evaluation_evaluations_portlet::uninstall.delete_evaluations_ds">      
      <querytext>

	select portal_datasource__delete(:ds_id)
    
      </querytext>
</fullquery>

<fullquery name="evaluation_admin_portlet::uninstall.delete_admin_ds">      
      <querytext>

	select portal_datasource__delete(:ds_id)
    
      </querytext>
</fullquery>
 
</queryset>

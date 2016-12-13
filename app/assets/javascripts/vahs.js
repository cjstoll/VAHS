//= require jquery.min
//= require jquery-ui.min
//= require bootstrap
//= require angular.min
//= require angular-ui.min
//= require jquery.table2excel

$( document ).ready(function() {

	$('#docdate').datepicker( {
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        dateFormat: 'yy-mm',
        onClose: function(dateText, inst) { 
            $(this).datepicker('setDate', new Date(inst.selectedYear, inst.selectedMonth, 1));
        }
    });
	$('#docdate').datepicker("setDate",new Date(2013, 1, 1));
	$('#docdate').datepicker("option","defaultDate",new Date(2013, 1, 1));
	
});

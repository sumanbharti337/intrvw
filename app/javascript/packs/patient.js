import "../stylesheets/adminlte/plugins/datatables/dataTables.bootstrap4.css";
import "../stylesheets/adminlte/plugins/datatables/responsive.dataTables.min.css";

import "../stylesheets/adminlte/plugins/datatables/jquery.dataTables.js";
import "../stylesheets/adminlte/plugins/datatables/dataTables.responsive.min.js";
import "../stylesheets/adminlte/plugins/datatables/dataTables.bootstrap4.js";
var patients_datatable = '';
// $(document).ready(function () {
    if(patients_datatable!='') {
        patients_datatable.destroy();
    }
patients_datatable = $('#patients-datatable').dataTable({
        "responsive": true,
        "processing": true,
        "serverSide": true,
        "destroy": true,
        "ajax": {
            "url": $('#patients-datatable').data('source')
        },
        "pagingType": "full_numbers",
        "columns": [
            {"data": "id"},
            {"data": "name"},
            {"data": "age"},
            {"data": "email"},
            {"data": "mobile"},
            {"data": "action"}
        ],
        "columnDefs": [ {
            "targets": 5,
            "orderable": false,
            "searchable": false,
            "render": function ( data, type, full, meta ) {
                return '<a href="/patients/'+full.DT_RowId+'" class="btn btn-sm btn-success"><i class="fa fa-eye" style="color: #ffffff;"></i></a> <a href="/patients/'+full.DT_RowId+'/edit" class="btn btn-sm btn-primary"><i class="fa fa-pencil-square" style="color: #ffffff;"></i></a> <a href="/patients/'+full.DT_RowId+'" class="btn btn-sm btn-danger" data-confirm="Are you sure?" rel="nofollow" data-method="delete"><i class="fa fa-trash" style="color: #ffffff;"></i></a>';
            }
        } ]
    });
// });
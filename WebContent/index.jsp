<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Student Management</title>
		
        <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.css"/>
        <link rel="stylesheet" href="dist/css/formValidation.css"/>
        <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="dist/js/formValidation.js"></script>
        <script type="text/javascript" src="dist/js/framework/bootstrap.js"></script>
		<!--<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
		<script src="js/bootstrap.min.js" type="text/javascript"></script>
		<link rel="stylesheet" href="css/bootstrap.min.css">-->
		<link href="css/style.css" rel="stylesheet">
	</head>
	<body>
		<div class="container">
			<div class="page-header"><h1>Student Management</h1></div>
			<div class='panel panel-success'>
				<div class="head form-inline panel-heading">
					<!--search-->
					<div class="form-group">
						<label for="search">Search by Name: </label>
						<input class='form-control' type="text" id="txt_search" name="txt_search" placeholder="eg: Lun Sovathana">
					</div>
					
					<!--class-->
					<select class='form-control' name="txt_class" id="txt_class" onchange="search()">
						<!--<option value="all">All Class</option>
						<option value="BTB">BTB</option>
						<option value="PP">PP</option>
						<option value="KPS">KPS</option>
						<option value="SR">SR</option>-->
					</select>
					
					<!--status-->
					<select class='form-control' name="txt_status" id="txt_status" onchange="search()">
						<option value="all">All Status</option>
						<option value="1">Active</option>
						<option value="0">Deactive</option>
					</select>
					
					<!-- button add -->
					<input class='btn btn-default' type="button" id="btn_add" value="New" title="Add New Student" onclick="changeModal(this);" data-toggle="modal" data-target="#modalForm">
				</div>
				
				<!-- table -->	
				<div id="display" class="panel-body">
					
				</div>
			
				<!-- footer -->
				<div class="panel-footer">
					
				</div>
			</div>
			
			<!-- footer -->
			<div class="page-footer">
				<p>Copyrigh &copy; Lun Sovathana</p>
			</div>
		</div>
		
		
		<!--modal form-->
        <!--add or update form-->
		<div class="modal fade" id="modalForm">
          <div class="modal-dialog">
            <div class="modal-content">
              <!--modal header-->
               <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Modal title</h4>
              </div><!--end modal header-->
              
              <!--modal body-->
              <div class="modal-body">
                <form id="inputForm" method="post" class="form-horizontal">
                    
                      <div class="form-group">
                        <label class="col-sm-3 control-label">ID</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" name="stuId" id="stuId" placeholder="Ex: 131N01" />
                        </div>
                    </div>
                     
                      
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Full name</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="firstName" id="firstName" placeholder="First name" />
                        </div>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="lastName" id="lastName" placeholder="Last name" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Gender</label>
                        <div class="col-sm-6">
                            <div class="radio">
                                <label>
                                    <input type="radio" name="gender" value="male" id="male" /> Male
                                </label>
                            </div>
                            <div class="radio">
                                <label>
                                    <input type="radio" name="gender" value="female" id="female" /> Female
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    
                      <div class="form-group">
                        <label class="col-sm-3 control-label">University</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" name="stuUniversity" id="stuUniversity" placeholder="Ex: NORTON" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Class</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" name="stuClass" id="stuClass" placeholder="Ex: BTB" />
                        </div>
                    </div>
                      
                    <div class="form-group">
                        <div class="col-sm-9 col-sm-offset-3">
                            <button type="submit" class="btn btn-primary" name="save" id="save" value="Save">Save</button>
                            <button type="reset" class="btn btn-default" name="clear" value="Clear">Clear</button>
                        </div>
                    </div>
                </form>
              </div><!--end modal body-->
              
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
		<!--end add or update form-->
		
		<!--delete confirmation form-->
		<div class="modal fade" id="modalDelete">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Confirm</h4>
              </div>
              <div class="modal-body">
                  <p>Are you sure want to delete student ID: <span id="confirmId"></span></p>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancel" onclick="clearDelete()">Cancel</button>
                <button type="button" class="btn btn-danger" id="btnDelete" onclick="deleteStudent(this)">Delete</button>
              </div>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
		<!--end delete confirmation form-->
		
		<!--end modal form-->
		
		
	</body>
	<script>
		$(document).ready(function(){
			
            // call list to show
            getClassList(); 
			viewStudent(); 
			
			// search
			$('#txt_search').on('input', function(){
				search();
			});
            
            // validate the input form

            $('#inputForm').formValidation({
                message: 'This value is not valid',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    firstName: {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'The first name is required'
                            }
                        }
                    },
                    lastName: {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'The last name is required'
                            }
                        }
                    },
                    stuId: {
                        message: 'The ID is not valid',
                        validators: {
                            notEmpty: {
                                message: 'The ID is required'
                            },
                            stringLength: {
                                min: 6,
                                max: 6,
                                message: 'The ID must be 6 characters'
                            },
                            regexp: {
                                regexp: /^[a-zA-Z0-9]+$/,
                                message: 'The ID can only consist of alphabetical and number'
                            }
                        }
                    },
                    stuUniversity: {
                        validators: {
                            notEmpty: {
                                message: 'The university is required'
                            }
                        }
                    },
                    stuClass: {
                        validators: {
                            notEmpty: {
                                message: 'The class is required'
                            },
                            stringLength: {
                                min: 3,
                                max: 5,
                                message: 'The class must be at lease 3 and max is 5 character'
                            }
                        }
                    },
                    gender: {
                        validators: {
                            notEmpty: {
                                message: 'The gender is required'
                            }
                        }
                    }
                }
            }).on('success.form.fv', function(e) {
                // Prevent form submission
                e.preventDefault();

                // Some instances you can use are
                var $form = $(e.target),        // The form instance
                    fv    = $(e.target).data('formValidation'); // FormValidation instance

                // start process
                if($('#save').val() == 'Save'){
                    // call add function
                    addStudent();
                    //alert('Save');
                }else{
                    // call update function
                    updateStudent();
                    //alert('Update');
                }
                
            });
            
            // reset form on close
            $('#modalForm').on('hidden.bs.modal', function(){
                $(this).find('form')[0].reset();
                // clear id state
                $('#stuId').removeAttr('disabled');
                // clear gender checkstate
                $('#male').removeAttr('checked');
                $('#female').removeAttr('checked');
            });
		});
		
        // get class list
        function getClassList(){
            var classList = "";
            classList += "<option value='all'>All Class</option>";
            $.get('getClassList.ktv', function(data){
                for(var i=0; i<data.length; i++){
                    classList += "<option value='"+data[i]+"'>"+data[i]+"</option>";
                }
                // add class list to select element
                $('#txt_class').html(classList);
            });
            
            
        }
        
		// view student
		function viewStudent(){
			$.getJSON("viewStudent.ktv", function(data){
				$('#display').html(displayList(data));
			});
		} // end view student
		
		
		// display list of student
		function displayList(data){
			var list = "";
			list += "<table class='table table-striped table-bordered'>";
				list += "<tr>";
					list += "<th class='center'>ID</th>";
					list += "<th class='center'>Name</th>";
					list += "<th class='center'>Gender</th>";
					list += "<th class='center'>University</th>";
					list += "<th class='center'>Class</th>";
					list += "<th class='center'>Status</th>";
                    list += "<th class='center'>Action</th>";
				list += "</tr>";
				
				// loop data to table
				for(var i=0; i<data.length; i++){
					list += "<tr>";
                        list += "<td>"+data[i].stu_id+"</td>";
                        list += "<td>"+data[i].stu_name+"</td>";
                        var gender = data[i].stu_gender;
                        list += "<td class='center'>"+((gender=='1')?'Male':'Female')+"</td>";
                        list += "<td class='center'>"+data[i].stu_university+"</td>";
                        list += "<td class='center'>"+data[i].stu_class+"</td>";

                        var img = "";
                        var status = "";
                        if(data[i].stu_status == 1){
                            img = "check.png";
                            status = "1";
                        }else{
                            img = "uncheck.png";
                            status = "0";
                        }

                        list += "<td class='center'><img class='status' stu_id='"+data[i].stu_id+"' status='"+status+"' src='img/"+img+"' onclick='updateStatus(this);'></td>";
                        // action block
                        list += "<td class='center'>";
                            list += "<div class='btn-group'>";
                                list += "<input class='btn btn-success' type='button' id='update' stu_id='"+data[i].stu_id+"' value='Edit' title='Update Student Info' onclick='changeModal(this); fillInfo(this);' data-toggle='modal' data-target='#modalForm'>";
                                list += "<input class='btn btn-danger' type='button' value='Delete' stu_id='"+data[i].stu_id+"' onclick='addIdToDelete(this)' data-toggle='modal' data-target='#modalDelete'>";
                            list += "</div>";
                        list += "</td>";
					list += "</tr>";
				}
			list += "</table>";
			
			var footer = "<p class='label label-info'>Total Student: " + data.length + "</p>";
			$('.panel-footer').html(footer);
			
			return list;
		}
		
		// search
		function search(){
			// get id from input
			var txt_name = $('#txt_search').val();
			var txt_class = $('#txt_class').val();
			var txt_status = $('#txt_status').val();
			
			// create data object
			var std = {stu_name: txt_name, stu_class: txt_class, stu_status: txt_status};
			
			// post data
			$.post("searchStudent.ktv", std, function(data){
				$('#display').html(displayList(data));
			});
		}
		
		// update student status
		function updateStatus(selector){
			var status = $(selector).attr('status');
			var id = $(selector).attr('stu_id');
			if(status == '0'){
				status = '1';
			}else{
				status = '0';
			}
			
			$.post("updateStatus.ktv", { stu_id: id, stu_status: status }, function(data){
				var img = "img/check.png";
				if(status==0)
					img = "img/uncheck.png";
	 			// change image
				$(selector).attr('src', img);
	 			// change status attribute
	 			$(selector).attr('status', status);
			});
		}
		
        // chang modal name
        function changeModal(selector){
            var modalTitle = $(selector).attr('title');
            $('.modal-title').html(modalTitle);
            // change the save button action
            if(modalTitle == 'Add New Student'){
                $('#save').html('Save'); 
                $('#save').val('Save');
            }else{
                $('#save').html('Save Changes'); 
                $('#save').val('Save Changes'); 
            }
        }
        
        // check id
        function checkId(id){
            $.get('checkStudentId.ktv', {stu_id: id}, function(data){
                var status = false;
                if(data.localeCompare(id)==0){
                    status = true;   
                }
                
                callback(status);
                //return status;
            });
        }
        
        // add student
        function addStudent(){
            var id = $('#stuId').val();
            $.get('checkStudentId.ktv', {stu_id: id}, function(data){
                if(data.localeCompare(id)==0){
                    alert('ID is already exist.');
                }else{
                    // do process when id is not exist 
                    var name = $('#firstName').val() + " " + $('#lastName').val();
                    var gender = $('input[name=gender]').val();
                    var university = $('#stuUniversity').val();
                    var sClass = $('#stuClass').val();
                    $.ajax("addStudent.ktv",{
                        method: 'POST',
                        data: {
                            stu_id: id,
                            stu_name: name,
                            stu_gender: gender,
                            stu_university: university,
                            stu_class: sClass
                        },
                        success: function(d){
                            alert("New Student has been added.");
                            // clear and hide the form
                            $('#inputForm').trigger('reset');
                            $('#modalForm').modal('toggle');
                            // reload data
                            getClassList();
                            viewStudent();
                        },
                        error: function(d){
                            alert("Cannot add student.");        
                        }
                    });
                }
                
            });
        }
        
        // fill information to modal for update
        function fillInfo(student){
            var id = $(student).attr('stu_id');
            // select data from database
            $.post('viewStudentById.ktv', {stu_id: id}, function(data){
                $('#stuId').val(data.stu_id);
                // disable the id field
                $('#stuId').attr('disabled', 'disabled');
                
                $('#firstName').val(data.stu_name.split(' ')[0]);
                $('#lastName').val(data.stu_name.split(' ')[1]);
                
                var gender = data.stu_gender;
                if(gender.localeCompare('1')==0){
                    $('#male').attr('checked', 'checked');
                }else{
                    $('#female').attr('checked', 'checked');   
                }
                
                $('#stuUniversity').val(data.stu_university);
                $('#stuClass').val(data.stu_class);
            });
        }
        
        // update student
        function updateStudent(){
            var id = $('#stuId').val();
            var name = $('#firstName').val() + " " + $('#lastName').val();
            var gender = $('input[name=gender]').val();
            var university = $('#stuUniversity').val();
            var sClass = $('#stuClass').val();
            
            $.ajax("updateStudent.ktv",{
                method: 'POST',
                data: {
                    stu_id: id,
                    stu_name: name,
                    stu_gender: gender,
                    stu_university: university,
                    stu_class: sClass
                },
                success: function(d){
                    // clear and hide the form
                    alert("Your modify has been saved.");
                    $('#inputForm').trigger('reset');
                    $('#modalForm').modal('toggle');
                    // reload data
                    getClassList();
                    viewStudent();
                },
                error: function(d){
                    alert("Cannot update student.");        
                }
            });
        }
        
        // add id to delete modal form
        function addIdToDelete(selector){
            // add student id to delete to modal confirmation form
            $('#confirmId').html($(selector).attr('stu_id')); 
            // add id to btnDelete attribute
            $('#btnDelete').attr('stu_id', $(selector).attr('stu_id'));    
        }
        
        // clear delete
        function clearDelete(){
            // clear student id from #confirmId
            $('#confirmId').html('');
            // remove stu_id attribute from btnDelete
            $('#btnDelete').removeAttr('stu_id');
        }
        
        // delete student
        function deleteStudent(selector){
           $.post('deleteStudent.ktv', {
               stu_id: $(selector).attr('stu_id')
           }, 
            function(){
               // close form
               $('#modalDelete').modal('toggle');
               // refresh list
               getClassList();
               viewStudent();
               // clearDelete
               clearDelete();
               
           });
        }
        
	</script>
	
    
    <!--validate the form-->
    
    <script>
        
    </script>
    
</html>
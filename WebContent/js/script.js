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

                        list += "<td class='center'><img class='status' stu_id='"+data[i].stu_id+"' status='"+status+"' src='img/"+img+"' title='Change Status' onclick='updateStatus(this);'></td>";
                        // action block
                        list += "<td class='center'>";
                            list += "<div class='btn-group'>";
                                list += "<button class='btn btn-success glyphicon glyphicon-pencil' type='button' id='update' stu_id='"+data[i].stu_id+"' title='Update Student Info' onclick='changeModal(this); fillInfo(this);' data-toggle='modal' data-target='#modalForm'></button>";
                                list += "<button class='btn btn-danger glyphicon glyphicon-trash' type='button' stu_id='"+data[i].stu_id+"' title='Delete Student' onclick='addIdToDelete(this)' data-toggle='modal' data-target='#modalDelete'></button>";
                            list += "</div>";
                        list += "</td>";
					list += "</tr>";
				}
			list += "</table>";
			
			var footer = "<h4><label class='label label-success'>Total Student: " + data.length + "</label></h4>";
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
        
        // add student
        function addStudent(){
            var id = $('#stuId').val();
            $.get('checkStudentId.ktv', {stu_id: id}, function(data){
                if(data.localeCompare(id)==0){
                    $('.bs-example').attr('style', 'display:block');
                    $('.message').html('ID is already exist.');
                    // change input box to error
                    $('i[data-fv-icon-for=stuId]').removeClass('glyphicon-ok').addClass('glyphicon-remove');
                    $('i[data-fv-icon-for=stuId]').parentsUntil('form').removeClass('has-success').removeClass('has-error');
                }else{
                    // do process when id is not exist 
                    var name = $('#firstName').val() + " " + $('#lastName').val();
                    var gender = $('input[name=gender]:checked').val();
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
                            swal("Congratulation!", "New Student has been added successfully.", "success");
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
            var gender = $('input[name=gender]:checked').val();
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
                	swal("Congratulation!", "Your record has been modified.", "success")
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
               swal("Congratulation!", "Student has been deleted.", "success")
               // refresh list
               getClassList();
               viewStudent();
               // clearDelete
               clearDelete();
               
           });
        }
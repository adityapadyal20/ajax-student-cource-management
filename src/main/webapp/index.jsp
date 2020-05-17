<html>
<head>
<title>Student Cource Project</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="//cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">

</head>
<body>
	<nav class="navbar navbar-dark bg-primary">
  	<h2 style="color:white">Student Course Management System</h2>
	</nav>
	<br>
	<div class = "row">
		<div class ="col-md-4">
			<div class ="container">
				<form id ="formStudent" name="formStudent">
					<div class ="form-group">
						<lable>Student Name:</lable>
						<input type="text" name="stname" id="stname" class ="form-control" placeholder="Student Name" required>
					</div>
					<div class ="form-group	">
						<lable>Course:</lable>
						<input type="text" name="course" id="course" class ="form-control" placeholder="Course" required>
					</div>
					<div class ="form-group">
						<lable>Cource Fee:</lable>
						<input type="text" name="courseFee" id="courseFee" class ="form-control" placeholder="Course Fee" required>
					</div>
					
					<div class ="form-group">
						<button type="button" class="btn btn-info" id="save" onclick="addStudent()">Register</button>
						<button type="button" class="btn btn-warning" id="reset" onclick="reset()">Reset</button>
					</div>
				</form>	
			</div>
		</div>
		
		<div class ="col-md-8">
			<div class ="panel-body">
				<table id="student-table" class="table table-bordered" cellpadding="0" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	
	<script src="component/jquery/jquery.js" type="text/javascript"></script>
	<script src="component/jquery/jquery.min.js" type="text/javascript"></script>
	<script src="component/jquery.validate.min.js" type="text/javascript"></script>
	<script src="//cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js" type="text/javascript"></script>
	
	<script>
		getAll();
		var isNew = true;
		var studentid = null;
		
		function addStudent()
		{
			if($("#formStudent").valid()){
				
				var url="";
				var data="";
				var method;
				
				if(isNew==true){
					url = 'add.jsp';
					data = $("#formStudent").serialize();
					method = 'POST'	
				}else{
					url = 'update.jsp';
					data = $("#formStudent").serialize() + "&studentid=" +studentid;
					method = 'POST'
					//alert("update successfull");
				}
				$.ajax({
					type: method,
					url: url,
					datatype: 'JSON',
					data: data,
					
					success:function(data){
						getAll();
						
						$('#stname').val("");
						$('#course').val("");
						$('#courseFee').val("");
						
						if(isNew==true){
							alert("Record Added");
						}
						else{
							alert("update successfull");
						}
					}
				})
			}
		}
		
		function getAll(){
			$('#student-table').dataTable().fnDestroy();
			$.ajax({
				url : 'allstudent.jsp',
				type: "GET",
				dataType: "JSON",
					
				success:function(data){
					$('#student-table').dataTable({
						"aaData":data,
						"scrollX":true,
						"aoColumns":
						[
							{"sTitle":"Student Name","mData": "name"},
							{"sTitle":"Course","mData": "course"},
							{"sTitle":"Fee","mData": "fee"},
							{
								"sTitle":
								"Edit",
								"mData": "id",
								"render" : function(mData,type,row,meta){
									return '<button class="btn btn-success" onclick="getDetails('+ mData +')">Edit</button>';
									
									}
								},
								{
									"sTitle":
									"Delete",
									"mData": "id",
									"render" : function(mData,type,row,meta){
										return '<button class="btn btn-danger" onclick="deleteRecords('+mData+')">Delete</button>';
										}
									},
						]
					})
				}
			})
		}
		
		function getDetails(id){
			$.ajax({
				type: "POST",
				url: "edit.jsp",
				data: {"id": id},
				
				success: function(data){
					isNew = false;
					var obj = JSON.parse(data);
					studentid = obj[0].stud_id;
					$('#stname').val(obj[0].stud_name);
					$('#course').val(obj[0].stud_course);
					$('#courseFee').val(obj[0].stud_fee);
				}
			})
		} 
		
	 	function deleteRecords(id){
			$.ajax({
				type:'POST',
				url:'deleteRecords.jsp',
				datatype:'JSON',
				data :{"id" : id},
			
			success: function(data){
				alert("Record deleted");
				getAll()
			}
			})
		} 
	</script>
</body>
</html>

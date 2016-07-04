<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>Testing Http Request Data</title>
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#submitBtn").click(function(event) {
				event.preventDefault();
				var data = '[{uName:"Lynn",uAge:13},{uEmail:"anfslove@163.com",uNic:"Andy"}]';
				$.post('get_http_data.cfm', data, function(reData) {
					
				});
			});
		});
	</script>
</head>
<body>
	<h1>Test Http Request Data</h1>
	<input type="button" id="submitBtn" value="Post">
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
<title>Imagemagick Upload</title>
<style>
</style>
<script type="text/javascript" src="script/jquery-1.8.2.js"></script>
<script type="text/javascript">
$(document).ready( function() {
	$(".upload-click").click(function(e){	
                //$('#input-file-upload').trigger('click');                
	});
});
	
    function uploadFile(fileid){
		var loaded = false;
		if(window.File && window.FileReader && window.FileList && window.Blob){
			if($(fileid).val()){ //check empty input filed
				oFReader = new FileReader(), rFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
				if($(fileid)[0].files.length === 0){return}			
				var oFile = $(fileid)[0].files[0];
				var fsize = $(fileid)[0].files[0].size; //get file size
				var ftype = $(fileid)[0].files[0].type; // get file type
				
				if(!rFilter.test(oFile.type)) 
				{
					alert('Unsupported file type!');
					return false;
				}
					
				var allowed_file_size = 30194304;	
							
				if(fsize>allowed_file_size)
				{
					alert('File too big! Allowed size 10 MB');
					return false;
				}
								
				var mdata = new FormData();
				mdata.append('image_data', $(fileid)[0].files[0]);
				
				jQuery.ajax({
					type: "POST", // HTTP method POST or GET
					processData: false,
					contentType: false,
					url: "Uploadimg", //Where to make Ajax calls Uploading?proid=
					data: mdata, //Form variables
					dataType: 'json',
					success:function(response){
                                                //alert("ss");
						//$(".upload-image").hide();
						//$(".upload-click").show();
//						if(response.type == 'success'){
//							$("#server-response").html('<div class="success">' + response.msg + '</div>');
//						}else{
//							$("#server-response").html('<div class="error">' + response.msg + '</div>');
//						}
					},
                                        complete:function(response)
                                        {
                                            $(".upload-click").val("complete");
                                            $(".upload-click").css("display","none");    
                                        },
                                        beforeSend:function(response)
                                        {
                                            $(".upload-click").val("uploading");
                                              //  $(".upload-click").css("display","none");
                                            
                                        }
                                        
				});
				
			}
			
		}else{
			alert("Can't upload! Your browser does not support File API! Try again with modern browsers like Chrome or Firefox.</div>");
			return false;
		}
		
    }

</script>
    </head>
    <body>
        <h1>Ajax Image Upload with PHP ImageMagick</h1>
<div class="upload-wrapper">
    <input type="file" id="input-file-upload" /><input type="file" id="input-file-upload1" /><input value="upload" type="button" class="upload-click">
</div>
    </body>
</html>

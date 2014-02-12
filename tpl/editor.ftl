<#macro edit_json path>

<#set currentUser = _session.getAttribute("_currentUser")>
<#if (currentUser?? && _owner == currentUser.email)>
	<div style="position:relative; z-index:100;">
		<div class="edit-pencil" style="position:absolute;top:0;right:0;"><a class="btn btn-minier btn-danger" href="/weblet/json${path}"><i class="icon-edit"></i></a></div>
	</div>
</#if>
</#macro>

<#macro file path>

<#set currentUser = _session.getAttribute("_currentUser")>
<#if (currentUser?? && _owner == currentUser.email)>
	<div style="position:relative; z-index:100;">
		<div class="edit-pencil" ><a style="position:absolute;top:0;right:0;" class="btn btn-minier btn-danger" href="/weblet/files${path}"><i class="icon-edit"></i></a></div>
	</div>
</#if>
</#macro>


<#macro image_upload path name >

<#set currentUser = _session.getAttribute("_currentUser")>
<#if (currentUser?? && _owner == currentUser.email)>

	<div style="position:relative; z-index:100;">
			<div class="edit-pencil" style="position:absolute;top:0;right:0;" onclick="$('#file_upload_path').val('${path}');$('#file_upload_name').val('${name}'); $('#image_upload_button').fileupload('option','url','/weblet/upload/htdocs/upload');$('#image_upload_dialog').modal('show');return false;"><i class="icon-edit"></i></div>
	<#nested>
	</div>
<#else>
	<#nested>
</#if>

</#macro>

<#macro image_src path name default_val>
	<#compress>
	<#set json = _documentLoader.get(path)>
	<#if json[name]??>
  		<#set propVal = json[name]>
  	<#else>
  		<#set propVal = default_val>
  	</#if>
	${propVal}
	</#compress>
</#macro>
  
<#macro image_upload_dialog>  

<!-- Modal -->
	<div style="display:none;" class="modal" id="image_upload_dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title">Modal title</h4>
        </div>
        <div class="modal-body">
<input id="file_upload_path" type="hidden">
<input id="file_upload_name" type="hidden">  

<span class="btn btn-success fileinput-button">
        <i class="icon-plus icon-white"></i>
        <span>Select Image...</span>
        <!-- The file input field used as target for the file upload widget -->
        <input id="image_upload_button" type="file" name="files[]" >
</span>		
        </div>
        <div class="modal-footer">
          <a href="#" class="btn">Close</a>
          <a href="#" class="btn btn-primary">Save changes</a>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal --> 



<script src="/js/jquery.ui.widget.js"></script>
<script src="/js/jquery.iframe-transport.js"></script>
<script src="/js/jquery.fileupload.js"></script>


<script type="text/javascript">



	$(function() {

		$('#image_upload_button').fileupload({

        dataType: 'json',
        done: function (e, data) {
            $.each(data.result.files, function (index, file) {
               uploadCompleted(file.name)
            });
						
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
        }
    }).prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled');	
	});
	

        
        
      

	function uploadCompleted(fileName){
		var path = $('#file_upload_path').val();
		var name = $('#file_upload_name').val();
		var value = fileName;
		var data = {'path' : path, 'name' : name, 'value':'/upload/' + value};
	
		
		$.post('/weblet/file_action/saveJSONValue', $.param(data), function(data, status,jqXHR) {
			var json = $.parseJSON(jqXHR.responseText);
			var error = json.error;		
			if (error == 'success') {
				window.location.reload();
			} else if (error == 'folder_exists'){
				show_alert('a folder with the name is already exists!');
			} else {
				show_alert('unknow error!');
			}
			
		 
		});
	}



	
</script>

</#macro>



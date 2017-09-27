from django import forms

class UploadFileForm(forms.Form):
    user_email = forms.CharField(max_length=150)
    image = forms.FileField()
	
class DownloadFileForm(forms.Form):
    user_email = forms.CharField(max_length=150)
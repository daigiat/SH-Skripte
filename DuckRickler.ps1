#credits:I am Jakoby
#github.com/I-Am-Jakoby                                                                                         
#twitter.com/I_Am_Jakoby                                                                                                       
#instagram.com/i_am_jakoby                                                                                              
#youtube.com/c/IamJakoby

Add-Type -AssemblyName System.Windows.Forms;
$originalPOS = [System.Windows.Forms.Cursor]::Position.X;
$o=New-Object -ComObject WScript.Shell;
while (1) {$pauseTime = 3;if ([Windows.Forms.Cursor]::Position.X -ne $originalPOS){break}else {$o.SendKeys("{CAPSLOCK}");
Start-Sleep -Seconds $pauseTime}};
saps https://www.youtube.com/watch?v=L_B5kYSTK_Y;
sleep 4;
$o=New-Object -ComObject WScript.Shell;$o.SendKeys('f');
sleep 2
Add-Type -AssemblyName PresentationFramework 
[System.Windows.MessageBox]::Show('Don't leave your PC alone','Duckyricky',0)

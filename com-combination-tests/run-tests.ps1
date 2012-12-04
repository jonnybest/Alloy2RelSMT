Set-Alias z34 "C:\Program Files\Microsoft Research\Z3-4.0\bin\z3.exe"

ForEach($file in dir *.als -name){     
#    $next = "step44-"
#    $newf = $next + $file;
#    cp $file $newf

    java -cp C:\MyPrograms\Alloy\alloy4.jar edu.mit.csail.sdg.alloy4whole.ExampleUsingTheCompiler $file
    
    java -jar ../alloy2relsmt.jar -f $file
}
ForEach($smtfile in dir *.smt2 -name){     
    $timeout = 550
    ("z34 -st -v:1 -smt2 -T:" +$timeout + " "  +$smtfile) | Write-Output
    ("Begin check-sat " + (Get-Date))|  Write-Output 
    z34 -st -v:1 -smt2 -T:$timeout $smtfile
    ("End check-sat " + (Get-Date)) |  Write-Output 
}
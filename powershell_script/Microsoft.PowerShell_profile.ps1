New-Alias k kubectl
New-Alias g goto
New-Alias open ii 
New-Alias np notepad
New-Alias cl clear
New-Alias uzp Expand-7Zip
New-Alias czp Compress-7Zip
New-Alias rn Rename-Item
New-Alias pyc pycharm
New-Alias w web
Import-Module PSReadLine 
Import-Module 7Zip4Powershell 
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -BellStyle None

function x{
    param($app)
    Switch($app)
    {
        "notion"{
            Start-Process -Path "C:\Users\rachm\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Notion.lnk"
        }
        "obs"{
            Start-Process -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OBS Studio\OBS Studio (64bit).lnk"
        }
        "easymp"{
            Start-Process -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\EPSON Projector\EasyMP Network Projection\EasyMP Network Projection Ver.2.86.lnk"
        }
        "dc"{
            Start-Process -Path "C:\Users\rachm\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk"
        }
        "canva"{
            Start-Process -Path "C:\Users\rachm\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Canva.lnk"
        }
        "word"{
            Start-Process -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word.lnk"
        }
        "osu"{
            Start-Process -Path "C:\Users\rachm\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\osu!.lnk"
        }
        Default{
            Write-Error "Application not registered / parameter invalid"
        }
    }
}

function web {
    param (
        $website, $destination
    )
    if ($website -ceq 'yt')
        {
            switch($destination)
            {
                "pl1" { 
                    Start-Process "https://www.youtube.com/watch?v=vBYC31o3dVI"
                 }
                "pl2" { 
                    Start-Process "https://www.youtube.com/watch?v=DOjrQ9DByhA&t=1072s"
                 }
                "pl3" { 
                    Start-Process "https://www.youtube.com/watch?v=DOjrQ9DByhA&t=1072s"
                 }
                Default {
                    Start-Process "https://www.youtube.com"
                }
            }
        }
    elseif ($website -ceq 'gh') 
        {
            switch ($destination) {
                'ssrepo' { 
                    Start-Process "https://github.com/rchmdndy/starshipconfig"
                 }
                Default {
                    Start-Process "https://www.github.com"
                }
            }    
        }

    elseif ($website -ceq 'wa')
        {
            Start-Process "https://web.whatsapp.com/"
        }   

    elseif ($website -ceq 'elnino')
        {
            Start-Process "https://elnino20212.polines.ac.id/course/search.php?search=TI1A"
        }   
    elseif ($website -ceq '.') 
        {
            Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
        }
    else 
        {
            Write-Error 'Parameter invalid!'
        }
    }   



function c{
    param($place)
    Switch ($place)
    {
        "cpps"{
            Copy-Item 'C:\Users\rachm\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1' 'C:\Users\rachm\.config\powershell_script\'
        }
        default {
            Write-Error "Invalid parameter"
        }
    }
}

function cpwd{
    Set-Clipboard -Value "'${pwd}'"
}
function goto {
    param ($location)
    Switch ($location) 
    {
        "m"{
                Set-Location -Path "M:\"
                | cl
        }
        "c"{
                Set-Location -Path "C:\"
        }
        "e"{
                Set-Location -Path "E:\"
        }
        "home"{
            Set-Location -Path "C:\Users\rachm"
        }
        "start"{
            Set-Location -Path "C:\Users\rachm\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
        }
        "start2"{
            Set-Location -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"
        }
        "mk" {
            Set-Location -Path "D:\college backup\matkul"
        }
        "lda"{
            Set-Location -Path "D:\college backup\matkul\logika_dan_algoritma\Jobsheet"
        }
        "cding" {
            Set-Location -Path "M:\code"
        }
        "dl" {
            Set-Location -Path "C:\Users\rachm\Downloads"
        }
        "cpusim"{
            Set-Location -Path "C:\Program Files (x86)\CPU-OS Simulator"
        }
        "ssconf"{
            Write-Host "‼️Don't forget to pull first‼️" -ForegroundColor White -BackgroundColor DarkRed
            Set-Location -Path "C:\Users\rachm\.config"
        }
        default {
            Write-Error "Invalid location"
        }
    }
}

$ENV:KUBECONFIG = ".kube/prod-k8s-clcreative-kubeconfig.yaml;.kube/civo-k8s_test_1-kubeconfig;.kube/k8s_test_1.yml"
Set-PSReadLineKeyHandler -Key 'UpArrow' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key 'DownArrow' -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key 'Tab' -Function MenuComplete
Set-PSReadlineKeyHandler -Key 'Shift+Tab' -Function AcceptSuggestion

function kn {
    param (
        $namespace
        )
        
        if ($namespace -in "default","d") {
            kubectl config set-context --current --namespace=default
        } else {
        kubectl config set-context --current --namespace=$namespace
    }
}



# powershell completion for datree                               -*- shell-script -*-

function __datree_debug {
    if ($env:BASH_COMP_DEBUG_FILE) {
        "$args" | Out-File -Append -FilePath "$env:BASH_COMP_DEBUG_FILE"
    }
}

filter __datree_escapeStringWithSpecialChars {
    $_ -replace '\s|#|@|\$|;|,|''|\{|\}|\(|\)|"|`|\||<|>|&','`$&'
}

Register-ArgumentCompleter -CommandName 'datree' -ScriptBlock {
    param(
        $WordToComplete,
        $CommandAst,
        $CursorPosition
        )
        
        # Get the current command line and convert into a string
        $Command = $CommandAst.CommandElements
        $Command = "$Command"
        
        __datree_debug ""
        __datree_debug "========= starting completion logic =========="
        __datree_debug "WordToComplete: $WordToComplete Command: $Command CursorPosition: $CursorPosition"
        
        # The user could have moved the cursor backwards on the command-line.
        # We need to trigger completion from the $CursorPosition location, so we need
        # to truncate the command-line ($Command) up to the $CursorPosition location.
        # Make sure the $Command is longer then the $CursorPosition before we truncate.
        # This happens because the $Command does not include the last space.
        if ($Command.Length -gt $CursorPosition) {
            $Command=$Command.Substring(0,$CursorPosition)
    }
        __datree_debug "Truncated command: $Command"
        
        $ShellCompDirectiveError=1
        $ShellCompDirectiveNoSpace=2
        $ShellCompDirectiveNoFileComp=4
        $ShellCompDirectiveFilterFileExt=8
        $ShellCompDirectiveFilterDirs=16
        
        # Prepare the command to request completions for the program.
        # Split the command at the first space to separate the program and arguments.
        $Program,$Arguments = $Command.Split(" ",2)
        $RequestComp="$Program __complete $Arguments"
        __datree_debug "RequestComp: $RequestComp"
        
        # we cannot use $WordToComplete because it
        # has the wrong values if the cursor was moved
        # so use the last argument
        if ($WordToComplete -ne "" ) {
            $WordToComplete = $Arguments.Split(" ")[-1]
        }
        __datree_debug "New WordToComplete: $WordToComplete"
        
        
        # Check for flag with equal sign
        $IsEqualFlag = ($WordToComplete -Like "--*=*" )
        if ( $IsEqualFlag ) {
            __datree_debug "Completing equal sign flag"
            # Remove the flag part
            $Flag,$WordToComplete = $WordToComplete.Split("=",2)
        }
        
        if ( $WordToComplete -eq "" -And ( -Not $IsEqualFlag )) {
            # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go method.
        __datree_debug "Adding extra empty parameter"
        # We need to use `"`" to pass an empty argument a "" or '' does not work!!!
        $RequestComp="$RequestComp" + ' `"`"'
    }
    
    __datree_debug "Calling $RequestComp"
    #call the command store the output in $out and redirect stderr and stdout to null
    # $Out is an array contains each line per element
    Invoke-Expression -OutVariable out "$RequestComp" 2>&1 | Out-Null
    
    
    # get directive from last line
    [int]$Directive = $Out[-1].TrimStart(':')
    if ($Directive -eq "") {
        # There is no directive specified
        $Directive = 0
    }
    __datree_debug "The completion directive is: $Directive"
    
    # remove directive (last element) from out
    $Out = $Out | Where-Object { $_ -ne $Out[-1] }
    __datree_debug "The completions are: $Out"
    
    if (($Directive -band $ShellCompDirectiveError) -ne 0 ) {
        # Error code.  No completion.
        __datree_debug "Received error from custom completion go code"
        return
    }
    
    $Longest = 0
    $Values = $Out | ForEach-Object {
        #Split the output in name and description
        $Name, $Description = $_.Split("`t",2)
        __datree_debug "Name: $Name Description: $Description"
        
        # Look for the longest completion so that we can format things nicely
        if ($Longest -lt $Name.Length) {
            $Longest = $Name.Length
        }
        
        # Set the description to a one space string if there is none set.
        # This is needed because the CompletionResult does not accept an empty string as argument
        if (-Not $Description) {
            $Description = " "
        }
        @{Name="$Name";Description="$Description"}
    }
    
    
    $Space = " "
    if (($Directive -band $ShellCompDirectiveNoSpace) -ne 0 ) {
        # remove the space here
        __datree_debug "ShellCompDirectiveNoSpace is called"
        $Space = ""
    }
    
    if (($Directive -band $ShellCompDirectiveNoFileComp) -ne 0 ) {
        __datree_debug "ShellCompDirectiveNoFileComp is called"
        
        if ($Values.Length -eq 0) {
            # Just print an empty string here so the
            # shell does not start to complete paths.
            # We cannot use CompletionResult here because
            # it does not accept an empty string as argument.
            ""
            return
        }
    }
    
    if ((($Directive -band $ShellCompDirectiveFilterFileExt) -ne 0 ) -or
    (($Directive -band $ShellCompDirectiveFilterDirs) -ne 0 ))  {
        __datree_debug "ShellCompDirectiveFilterFileExt ShellCompDirectiveFilterDirs are not supported"
        
        # return here to prevent the completion of the extensions
        return
    }
    
    $Values = $Values | Where-Object {
        # filter the result
        $_.Name -like "$WordToComplete*"
        
        # Join the flag back if we have a equal sign flag
        if ( $IsEqualFlag ) {
            __datree_debug "Join the equal sign flag back to the completion value"
            $_.Name = $Flag + "=" + $_.Name
        }
    }
    
    # Get the current mode
    $Mode = (Get-PSReadLineKeyHandler | Where-Object {$_.Key -eq "Tab" }).Function
    __datree_debug "Mode: $Mode"
    
    $Values | ForEach-Object {
        
        # store temporay because switch will overwrite $_
        $comp = $_
        
        # PowerShell supports three different completion modes
        # - TabCompleteNext (default windows style - on each key press the next option is displayed)
        # - Complete (works like bash)
        # - MenuComplete (works like zsh)
        # You set the mode with Set-PSReadLineKeyHandler -Key Tab -Function <mode>
        
        # CompletionResult Arguments:
        # 1) CompletionText text to be used as the auto completion result
        # 2) ListItemText   text to be displayed in the suggestion list
        # 3) ResultType     type of completion result
        # 4) ToolTip        text for the tooltip with details about the object
        
        switch ($Mode) {
            
            # bash like
            "Complete" {
                
                if ($Values.Length -eq 1) {
                    __datree_debug "Only one completion left"
                    
                    # insert space after value
                    [System.Management.Automation.CompletionResult]::new($($comp.Name | __datree_escapeStringWithSpecialChars) + $Space, "$($comp.Name)", 'ParameterValue', "$($comp.Description)")
                    
                } else {
                    # Add the proper number of spaces to align the descriptions
                    while($comp.Name.Length -lt $Longest) {
                        $comp.Name = $comp.Name + " "
                    }
                    
                    # Check for empty description and only add parentheses if needed
                    if ($($comp.Description) -eq " " ) {
                        $Description = ""
                    } else {
                        $Description = "  ($($comp.Description))"
                    }
                    
                    [System.Management.Automation.CompletionResult]::new("$($comp.Name)$Description", "$($comp.Name)$Description", 'ParameterValue', "$($comp.Description)")
                }
             }
             
             # zsh like
             "MenuComplete" {
                 # insert space after value
                 # MenuComplete will automatically show the ToolTip of
                 # the highlighted value at the bottom of the suggestions.
                 [System.Management.Automation.CompletionResult]::new($($comp.Name | __datree_escapeStringWithSpecialChars) + $Space, "$($comp.Name)", 'ParameterValue', "$($comp.Description)")
                }
                
                # TabCompleteNext and in case we get something unknown
                Default {
                    # Like MenuComplete but we don't want to add a space here because
                    # the user need to press space anyway to get the completion.
                    # Description will not be shown because thats not possible with TabCompleteNext
                    [System.Management.Automation.CompletionResult]::new($($comp.Name | __datree_escapeStringWithSpecialChars), "$($comp.Name)", 'ParameterValue', "$($comp.Description)")
                }
            }
            
        }
    }

$ENV:STARSHIP_CONFIG = "$HOME\.config\starship_theme\starship.toml"
$ENV:STARSHIP_DISTRO = "<~ user "

Invoke-Expression (&starship init powershell)
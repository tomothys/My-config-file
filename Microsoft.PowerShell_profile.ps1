#---------#
# General #
#---------#
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward


#-------#
# PSFzf #
#-------#
# Install 'fd': https://github.com/sharkdp/fd/releases
# Install 'FZF': https://github.com/junegunn/fzf#windows
# Install 'PSFzf': Run the following command to install PSFZF "Install-Module -Name PSFzf"
# ---------------------------------------------------------------------------------------------------
# $env:FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude node_modules"
# Import-Module PSFzf
# Set-PsFzfOption -PSReadlineChordProvider "Ctrl+f" -PSReadlineChordReverseHistory "Ctrl+r"
# Function FuzzyChangeDirectory {
#     [Alias("fsl")]

#     Param()

#     if ($args) {
#         $path = $args
#     } else {
#         $path = "."
#     }

#     Get-ChildItem $path -Recurse | ? { $_.PSIsContainer } | Invoke-Fzf | Set-Location
# }


#--------------#
# Docker Alias #
#--------------#
# docker compose up
Function Docker-Compose-Up {
    [Alias("dock-up")]

    Param(
        [switch]$Recreate
    )
    
    if ($Recreate) {
        echo "docker compose up --force-recreate --build"
        docker compose up --force-recreate --build
    } else {
        echo "docker compose up"
        docker compose up
    }
}

# docker compose down
Function Docker-Compose-Down { [Alias("dock-down")] Param() docker compose down $args }

# docker compose exec
Function Docker-Compose-Exec { [Alias("dock-exec")] Param() docker compose exec $args bash }


#-----------#
# git Alias #
#-----------#
Function Git-Clone-Recursive { [Alias("clone")] param() git clone --recurse-submodules $args }
Function Git-Checkout-Recursive { [Alias("checkout")] param() git checkout --recurse-submodules $args }
Function Git-Commit { [Alias("commit")] param() git commit -m "$args" }
Function Git-Push { [Alias("push")] param() git push }
Function Git-Pull { [Alias("pull")] param() git pull --recurse-submodules }
Function Git-Status { [Alias("status")] param() git status }
Function Git-Stage { [Alias("stage")] param() git add $args }
Function Git-Unstage { [Alias("unstage")] param() git restore --staged $args }
Function Git-Discard { [Alias("discard")] param() git restore $args }

Function Open-In-Explorer { [Alias("open")] param() explorer.exe $args }
Set-Alias -Name touch -Value New-Item


#-----------------#
# Init oh-my-posh #
#-----------------#
# agnosterplus.omp
# blue-owl.omp
# stelbent.minimal.omp
# Import-Module oh-my-posh
# Set-PoshPrompt -Theme agnosterplus

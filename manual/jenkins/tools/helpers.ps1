function Get-JavaHome {
    process {
        $WhereArgs = @('java')
        $Where = 'where.exe'
        $Path = Split-Path -Parent $(& $where @WhereArgs)
  
        return $((Split-Path -Parent $Path) + '\')
    }
}
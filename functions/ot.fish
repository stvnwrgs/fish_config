function ot --description "open [IT|DEVOPS] tickets"
        set realm = ""
        switch $argv[1]
                case 'i'
                        set realm 'IT'
                case 'd'
                        set realm 'DEVOPS'
                case '*'
                        echo "first param needs to be [i|d] for [IT|DEVOPS]"
        end
        if test -n $realm
                open "https://jira.collins.kg/browse/$realm-$argv[2]"
        end
end

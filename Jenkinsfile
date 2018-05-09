pipeline {

    agent any

    environment {
        HUB_ORG="${env.HUB_ORG_DH}"
        CONNECTED_APP_CONSUMER_KEY="${env.CONNECTED_APP_CONSUMER_KEY_DH}"
        jwt_key_file = credentials('git-jenkins-sfdx-test')
    }

    stages {
        stage('AUTHORIZING') {
            steps {
                sh '''
                    echo ${HUB_ORG}
                    echo $CONNECTED_APP_CONSUMER_KEY
                    export SFDX_USE_GENERIC_UNIX_KEYCHAIN=true
                    /usr/local/lib/sfdx/bin/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername -a HubOrg
                
                    /usr/local/lib/sfdx/bin/sfdx force:org:create --definitionfile config/project-scratch-def.json --json --setdefaultusername
                '''
            }
        }
    }
}
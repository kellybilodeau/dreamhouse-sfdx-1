pipeline {

    agent any

    environment {
        HUB_ORG="${env.HUB_ORG_DH}"
        CONNECTED_APP_CONSUMER_KEY="${env.CONNECTED_APP_CONSUMER_KEY_DH}"
        jwt_key_file = credentials('git-jenkins-sfdx-test')
        workspace="${workspace}"
    }

    stages {
        stage('AUTHORIZING') {
            steps {
                sh '''
                    export SFDX_USE_GENERIC_UNIX_KEYCHAIN=true
                    /usr/local/lib/sfdx/bin/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername -a DevHub
                 '''
            }
        }
        // stage('CREATING SCRATCH ORG') {
        //     steps {
        //         sh '''
        //            /usr/local/lib/sfdx/bin/sfdx force:org:create -s -f config/project-scratch-def.json -a testScratchOrg

        //             /usr/local/lib/sfdx/bin/sfdx force:org:display -u testScratchOrg
        //             /usr/local/lib/sfdx/bin/sfdx force:source:push -u testScratchOrg
        //             /usr/local/lib/sfdx/bin/sfdx force:apex:test:run -u testScratchOrg --wait 10
        //             /usr/local/lib/sfdx/bin/sfdx force:org:delete -u testScratchOrg -p
        //          '''
        //     }
        // }
        // stage('RUNNING APEX TESTS') {
        //     steps {
        //         sh '''
        //             /usr/local/lib/sfdx/bin/sfdx force:apex:test:run -u testScratchOrg --wait 10
        //          '''
        //     }
        // }
        // stage('DELETING SCRATCH ORG') {
        //     steps {
        //         sh '''
        //             /usr/local/lib/sfdx/bin/sfdx force:org:delete -u testScratchOrg -p
        //          '''
        //     }
        // }
        stage('DEPLOY') {
            steps {
                sh '''
                    /usr/local/lib/sfdx/bin/sfdx force:source:convert -r force-app -d deploy
                    /usr/local/lib/sfdx/bin/sfdx force:mdapi:deploy -d ${workspace}/test-pipeline/deploy -u DevHub
                    /usr/local/lib/sfdx/bin/sfdx force:mdapi:deploy:report
                 '''
            }
        }
    }
}
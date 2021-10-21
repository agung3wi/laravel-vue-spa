node {
    checkout scm
    docker.image('node:12').inside('-u root') {
        sh 'npm install'
        sh 'npm run build'
    }

    docker.image('shippingdocker/php-composer:7.4').inside('-u root') {
        sh 'composer install'
    }
    
    docker.image('agung3wi/alpine-rsync:1.1').inside('-u root') {
        sshagent (credentials: ['agung']) {
            sh 'mkdir -p ~/.ssh'
            sh 'ssh-keyscan -H "dev-env.agung3wi.xyz" > ~/.ssh/known_hosts'
            sh "rsync -rav --delete ./ ubuntu@dev-env.agung3wi.xyz:/home/ubuntu/dev-env.agung3wi.xyz/"
        }
    }
    
}

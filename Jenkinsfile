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
            sh 'ssh-keyscan -H "staging-env.agung3wi.xyz" > ~/.ssh/known_hosts'
            sh "rsync -rav --delete ./ ubuntu@staging-env.agung3wi.xyz:/home/ubuntu/staging-env.agung3wi.xyz/"
            sh "ssh ubuntu@staging-env.agung3wi.xyz 'cd ~/staging-env.agung3wi.xyz && php artisan migrate'"
        }
    }

    docker.image('agung3wi/alpine-rsync:1.1').inside('-u root') {
        sshagent (credentials: ['agung']) {
            sh 'mkdir -p ~/.ssh'
            sh 'ssh-keyscan -H "staging-env.agung3wi.xyz" > ~/.ssh/known_hosts'
            sh "ssh ubuntu@staging-env.agung3wi.xyz 'cd ~/staging-env.agung3wi.xyz && /vendor/bin/phpunit'"
        }
    }
    
    docker.image('agung3wi/alpine-rsync:1.1').inside('-u root') {
        sshagent (credentials: ['agung']) {
            sh 'mkdir -p ~/.ssh'
            sh 'ssh-keyscan -H "prod-env.agung3wi.xyz" > ~/.ssh/known_hosts'
            sh "rsync -rav --delete ./ ubuntu@prod-env.agung3wi.xyz:/home/ubuntu/prod-env.agung3wi.xyz/"
            sh "ssh ubuntu@prod-env.agung3wi.xyz 'cd ~/prod-env.agung3wi.xyz && php artisan migrate'"
        }
    }
    
}

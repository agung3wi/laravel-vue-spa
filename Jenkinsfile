node {
    checkout scm
    docker.image('node:12').inside('-u root') {
        sh 'npm install'
        sh 'npm run build'
    }

    docker.image('shippingdocker/php-composer:7.4').inside('-u root') {
        sh 'composer install'
    }
    
}

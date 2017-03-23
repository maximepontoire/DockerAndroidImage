node () {
  deleteDir()

  stage ('Checkout') {
    checkout scm
  }

  stage ('Create Env') {
      sh 'docker build -t "androidsdk24:1.0" .'
  }

}

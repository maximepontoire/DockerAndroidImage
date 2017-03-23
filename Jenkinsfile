node () {
  deleteDir()

  stage ('Checkout') {
    checkout scm
  }

  stage ('Create Env') {
      docker.build("androidsdk24:1.4"," .")
  }

}

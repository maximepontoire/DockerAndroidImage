node () {
  deleteDir()

  stage ('Checkout') {
    checkout scm
  }

  stage ('Create Env') {
      vscloud.partner="vsct"
      docker.build("docker-${vscloud.partner}.pkg.cloud.socrate.vsct.fr/mobilefactory/androidsdk25:1.1", "  --build-arg https_proxy=$VSCT_PROXY --build-arg http_proxy=$VSCT_PROXY --build-arg HTTP_PROXY=$VSCT_PROXY --build-arg HTTPS_PROXY=$VSCT_PROXY --build-arg NO_PROXY=$VSCT_NO_PROXY --build-arg no_proxy=$VSCT_NO_PROXY .")
  }

  stage ('Push Env') {
      vscloud.dockerPush("docker-${vscloud.partner}.pkg.cloud.socrate.vsct.fr/mobilefactory/androidsdk25:1.1")
  }

  //stage ('Publish to production') {
      // Avec affichage d'un promp pour saisie d'un login / pwd
      //vscloud.promoteArtifact()
      // Avec login / pwd en paramètre
      //vscloud.promoteArtifact(login="ss", passwd="dd")
  //}

}

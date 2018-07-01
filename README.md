# About

 Generates type-safe Terraform code:
  - [x] `*.tfvars`
  - [ ] `*.tf` (COMING SOON)

# Related repos

 - [terramake](https://github.com/karandit/terramake/)
    - cli tool written in NodeJs which invokes the generator (see below)
    - download from here https://www.npmjs.com/package/terramake
 - [elm-terramake](https://github.com/karandit/elm-terramake)
     - Terraform generator written in Elm
     - use any git server and [elm-github-install](https://www.npmjs.com/package/elm-github-install)
 - [terramake-modules-example](https://github.com/karandit/terramake-modules-example)
    - example for the provider part
    - based on Gruntwork's [terragrunt-infrastructure-modules-example](https://github.com/gruntwork-io/terragrunt-infrastructure-modules-example)
 - [terramake-live-example](https://github.com/karandit/terramake-live-example)
    - example for the consumer part
    - based on Gruntwork's [terragrunt-infrastructure-live-example](https://github.com/gruntwork-io/terragrunt-infrastructure-live-example)

# Start locally

    $ elm package install
    $ npm install -g elm-live
    $ elm-live src/*.elm --output=iac/iac.js

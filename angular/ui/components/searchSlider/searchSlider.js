import angular from 'angular';
import angularMeteor from 'angular-meteor';

import './searchSlider.html';

const name = 'searchSlider';

class SearchSlider {
  constructor($scope) {
    'ngInject';


    /*
     * Bind services
     */
    this.scope = $scope;


    /*
     * Asynchronous data
     */
    this.min = 1915;
    this.max = new Date().getFullYear();

    this.lowerMax = this.max - 1;
    this.upperMin = this.lower + 1;


    /*
     * Activate
     */
    this.validateData();
  }


  /*
   * Scope methods
   */
  update(prop) {
    this.onUpdate({ prop, value: this[prop] });

    if (prop === 'lower') {
      const number = 100 * ((this.max - this.lower + 1) / (this.max - this.min));

      this.upperWidth = `${number}%`;
      this.upperMin = this.lower + 1;

      if (this.lower > this.upper - 1 && this.upper < this.max) {
        this.upper = this.lower + 1;
        this.update('upper');
      }
    }
  }


  /*
   * Helpers
   */
  validateData() {
    if (!this.lower || this.lower < this.min) {
      this.lower = this.min;
    }

    if (!this.upper || this.upper > this.max) {
      this.upper = this.max;
    }
  }
}

export default angular
  .module(name, [
    angularMeteor,
  ])
  .component(name, {
    controllerAs: name,
    controller: SearchSlider,
    templateUrl: `imports/ui/components/${name}/${name}.html`,
    bindings: {
      upper: '<',
      lower: '<',
      onUpdate: '&',
    },
  });

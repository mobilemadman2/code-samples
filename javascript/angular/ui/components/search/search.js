import _ from 'lodash';
import angular from 'angular';
import uiRouter from 'angular-ui-router';
import ngMaterial from 'angular-material';
import angularMeteor from 'angular-meteor';

import { name as Profile } from '../profile/profile';
import { name as Slider } from '../searchSlider/searchSlider';

import './search.html';

const name = 'search';

const config = ($stateProvider) => {
  'ngInject';

  $stateProvider.state('portal.search', {
    url: '/search',
    abstract: true,
    template: '<div ui-view=""></div>',
  });

  $stateProvider.state('portal.search.index', {
    url: '',
    template: '<search></search>',
  });
};

class Search {
  constructor($scope, $window, $mdBottomSheet) {
    'ngInject';


    /*
     * Bind services
     */
    this.scope = $scope;
    this.mdBottomSheet = $mdBottomSheet;


    /*
     * Synchronous data
     */
    this.lower = 1915;
    this.filters = this.getFilters();
    this.columns = this.getColumns();
    this.upper = new Date().getFullYear();


    /*
     * Asynchronous data
     */
    this.alumni = [];
    this.alumniCount = 0;


    /*
     * Lookup
     */
    this.genders = [];


    /*
     * UI States
     */
    this.fabopen = false;
    this.showSearch = false;
    this.showFilterTabs = false;
    this.selectAllCheck = false;

    // The height of the infinite scroll list
    this.height = { height: this.getHeight($window.innerHeight) };


    /*
     * Activate
     */
    this.getGender();
    this.getAlumni();
    this.getSelectedColumn();
  }


  /*
   * Scope methods
   */
  onUpdate(prop, value) {
    this[prop] = value;
  }


  /*
   * Helpers
   */
  getGender() {
    Meteor.call('getGenders', (err, res) => {
      this.genders = res;
      this.scope.$apply();
    });
  }

  getAlumni() {
    Meteor.call('getAlumni', (err, res) => {
      this.alumni = res.map((row) => {
        const output = row;
        output.display = true;
        return output;
      });

      this.alumniCount = this.countAlumni();

      this.scope.$apply();
    });
  }

  getColumns() {
    this.columns = [{
      value: 'job',
      label: 'Job title',
      propertyId: 'Job__c',
      selected: false,
    }, {
      value: 'status',
      label: 'Current status',
      propertyId: 'Status__c',
      selected: false,
    }, {
      value: 'mobile',
      label: 'Mobile',
      propertyId: 'Mobile__c',
      selected: true,
    }, {
      value: 'leaving',
      label: 'Leaving date',
      propertyId: 'Leaving__c',
      selected: false,
    }, {
      value: 'undergraduate',
      label: 'Undergraduate Institution',
      propertyId: 'Undergraduate__c',
      selected: false,
    }];
  }

  getSelectedColumn() {
    if (this.columns) {
      for (let i = 0; i < this.columns.length; i++) {
        if (this.columns[i].selected) {
          this.selectedColumn = this.columns[i].value;
          break;
        }
      }
    }
  }

  countAlumni() {
    return this.alumni.filter((alumnus) => alumnus.display).length();
  }

  getFilters() {
    return {
      education: {
        summary: [],
        post16: [],
        apprenticeship: [],
        undergraduateInstitute: [],
        undergraduateSubject: [],
        postgraduateInstitute: [],
        postgraduateSubject: [],
      },
      employment: {
        title: [],
        sector: [],
        employer: [],
      },
      general: {
        gender: [],
        ableToVisit: [],
        occupation: [],
        support: [],
        leavingYearFrom: 1915,
        leavingYearUntil: 2016,
        // signedFrom: ,
        // signedUntil:
      },
      activity: {
        activity: [],
        type: [],
        attendedPrevious: [],
        // from: ,
        // until:
      },
      // questions: {
        // ?
      // },
    };
  }


  /*
   * UI methods
   */
  getHeight(height) {
    const output = height - 285;

    if (output > 3000) {
      return 3000;
    }

    if (output < 100) {
      return 100;
    }

    return output;
  }

  openMenu($mdOpenMenu, ev) {
    $mdOpenMenu(ev);
  }

  toggleTab() {
    this.showFilterTabs = !this.showFilterTabs;
  }

  toggleSearch() {
    this.showSearch = !this.showSearch;
  }

  toggleColumns() {
    for (let i = 0; i < this.columns.length; i++) {
      this.columns[i].selected = (this.columns[i].value === this.selectedColumn);
    }
  }

  searchByString() {
    this.visibleAlumni = 0;
    const reg = new RegExp(this.searchString);
    for (let i = 0; i < this.alumni.length; i++) {
      let alumniString = this.alumni[i].Name;
      alumniString += this.alumni[i].Last_name__c;
      alumniString += this.alumni[i].Email__c;
      const isVisible = this.alumni[i].display = reg.test(alumniString);
      if (isVisible) this.visibleAlumni++;
    }
  }

  hasElementsCheckedClass() {
    if (_.findIndex(this.alumni, (a) => a.isChecked) > -1) {
      return 'active';
    }

    return 'inactive';
  }

  selectAll() {
    for (let i = 0; i < this.alumni.length; i++) {
      this.alumni[i].isChecked = true;
    }
  }

  selectNone() {
    for (let i = 0; i < this.alumni.length; i++) {
      this.alumni[i].isChecked = false;
    }
  }

  toggleSelectAll() {
    if (this.selectAllCheck) {
      this.selectNone();
    } else {
      this.selectAll();
    }
  }


  /*
   * Actions
   */
  removeAlumnus(i) {
    this.alumni.splice(i, 1);
    // TODO: Call server-side
  }

  removeCheckedAlumni() {
    for (let i = 0; i < this.alumni.length; i++) {
      if (this.alumni[i].isChecked) {
        this.removeAlumnus(i);
        this.removeCheckedAlumni();
        break;
      }
    }
  }

}

export default angular
  .module(name, [
    uiRouter,
    ngMaterial,
    angularMeteor,

    Slider,
    Profile,
  ])
  .component(name, {
    controllerAs: name,
    controller: Search,
    templateUrl: `imports/ui/components/${name}/${name}.html`,
  })
  .config(config);

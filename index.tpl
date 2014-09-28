<div ng-controller="PartiesListCtrl">
  <form>
    <label>Name</label>
    <input ng-model="newParty.name">
    <label>Description</label>
    <input ng-model="newParty.description">
    <button ng-click="parties.push(newParty)">Add</button>
    <button ng-click="removeAll()">Remove All</button>
  </form>
  <ul>
    <li ng-repeat="party in parties">
      {{party.name}}
      <p>{{party.description}}</p>
      <button ng-click="remove(party)">X</button>
    </li>
  </ul>
</div>
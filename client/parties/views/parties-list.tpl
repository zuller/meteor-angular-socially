<form ng-show="$root.currentUser">
  <h2>Create a new party:</h2>
  <label>Name</label>
  <input ng-model="newParty.name">
  <label>Description</label>
  <input ng-model="newParty.description">
  <label>Public</label>
  <input type="checkbox" ng-model="newParty.public">
  <button ng-click="newParty.owner=$root.currentUser._id;parties.push(newParty)">Add</button>
</form>
<div ng-hide="$root.currentUser">
  Log in to create a party!
</div>
<ul>
  Parties:
  <div>
    Search
    <input type="search" ng-model="search">
    <select ng-model="orderProperty">
      <option value="name">Ascending</option>
      <option value="-name">Descending</option>
    </select>
  </div>
  <li ng-repeat="party in parties | filter:search | orderBy:orderProperty">
    <a href="/parties/{{party._id}}">{{party.name}}</a>
    <p>{{party.description}}</p>
    <button ng-click="remove(party)" ng-show="$root.currentUser && $root.currentUser._id == party.owner">X</button>
    <div ng-show="$root.currentUser">
      <input type="button" value="I'm going!" ng-click="rsvp(party._id, 'yes')">
      <input type="button" value="Maybe" ng-click="rsvp(party._id, 'maybe')">
      <input type="button" value="No" ng-click="rsvp(party._id, 'no')">
    </div>
    <div ng-hide="$root.currentUser">
      <i>Sign in to RSVP for this party.</i>
    </div>
    <div>
      Who is coming:
      Yes - {{ (party.rsvps | filter:{rsvp:'yes'}).length }}
      Maybe - {{ (party.rsvps | filter:{rsvp:'maybe'}).length }}
      No - {{ (party.rsvps | filter:{rsvp:'no'}).length }}
      <div ng-repeat="rsvp in party.rsvps | filter:{rsvp:'yes'}">
        {{ getUserById(rsvp.user) | displayName }} - {{ rsvp.rsvp }}
      </div>
      <div ng-repeat="rsvp in party.rsvps | filter:{rsvp:'maybe'}">
        {{ getUserById(rsvp.user) | displayName }} - {{ rsvp.rsvp }}
      </div>
      <div ng-repeat="rsvp in party.rsvps | filter:{rsvp:'no'}">
        {{ getUserById(rsvp.user) | displayName }} - {{ rsvp.rsvp }}
      </div>
    </div>
    <ul ng-if="!party.public">
      Users who not responded:
      <li ng-repeat="invitedUser in outstandingInvitations(party)">
        {{ invitedUser | displayName }}
      </li>
    </ul>
    <div ng-if="party.public">
      Everyone is invited
    </div>

    <p><small>Posted by {{ creator(party) | displayName }}</small></p>
  </li>
</ul>

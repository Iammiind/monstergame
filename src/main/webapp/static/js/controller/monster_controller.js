'use strict';
//TODO: Replace XXX with the answer!
App.controller('MonsterController', [
		'$scope',
		'MonsterService',
		function($scope, MonsterService) {
			var self = this;

			self.monster = {
				id : null,
				monstername : '',
				health : '',
				attack : ''
			};

			self.monsters = [];

			self.fetchAllMonsters = function() {
				//TODO: Uncomment and Replace XXX with the answer!
				MonsterService.fetchAllMonsters().then(function(d) {
					self.monsters = d;
				}, function(errResponse) {
					console.error('Error while fetching Monsters');
				});
			};

			self.createMonster = function(monster) {
				//TODO: Uncomment and Replace XXX with the answer!
				MonsterService.createMonster(monster).then(
						self.fetchAllMonsters, function(errResponse) {
							console.error('Error while creating Monster.');
						});
			};

			self.updateMonster = function(monster, id) {
				//TODO: Uncomment and Replace XXX with the answer!
				MonsterService.updateMonster(monster, id).then(
						self.fetchAllMonsters, function(errResponse) {
							console.error('Error while updating Monster.');
						});
			};

			self.deleteMonster = function(id) {
				//TODO: Uncomment and Replace XXX with the answer!
				MonsterService.deleteMonster(id).then(self.fetchAllMonsters,
						function(errResponse) {
							console.error('Error while deleting Monster.');
						});
			};

			self.fetchAllMonsters();

			self.submit = function() {
				if (self.monster.id === null) {
					console.log('Saving New Monster', self.monster);
					//TODO: Uncomment and Replace XXX with the answer!
					self.createMonster(self.monster);
				} else {
					//TODO: Uncomment and Replace XXX with the answer!
					self.updateMonster(self.monster, self.monster.id);
					console.log('Monster updated with id ', self.monster.id);
				}
				self.reset();
			};

			self.edit = function(id) {
				console.log('id to be edited', id);
				for (var i = 0; i < self.monsters.length; i++) {
					if (self.monsters[i].id === id) {
						self.monster = angular.copy(self.monsters[i]);
						break;
					}
				}
			};

			self.remove = function(id) {
				console.log('id to be deleted', id);
				if (self.monster.id === id) {// clean form if the monster to
					// be
					// deleted is shown there.
					self.reset();
				}
				//TODO: Uncomment and Replace XXX with the answer!
				self.deleteMonster(id);
			};

			self.reset = function() {
				self.monster = {
					id : null,
					monstername : '',
					health : '',
					attack : ''
				};
				$scope.myForm.$setPristine(); // reset Form
			};

			self.battleMode = false;
			self.monsterBattle = [
				{
					id : null
				},
				{
					id : null
				}
			];


			self.selectedMonster = function (monster) {
				var addFirstMonster = false;
				if(self.monsterBattle[0].id == null){
					self.monsterBattle[0] = monster;
					addFirstMonster = true;
				}

				if(self.monsterBattle[1].id == null && !addFirstMonster){
					self.monsterBattle[1] = monster;
				}

			};

			self.unselectedMonster = function (monster) {
				if(self.monsterBattle[0].id == monster.id){
					self.monsterBattle[0] = {
						id : null
					};
				}
				if(self.monsterBattle[1].id == monster.id){
					self.monsterBattle[1] = {
						id : null
					};
				}
			};

			self.isSelected = function(id) {

				if(self.monsterBattle[0].id == id){
					return true;
				}
				if(self.monsterBattle[1].id == id) {
					return true;
				}
				return false;
			};

			self.winner = null;
			self.fightMonster = function() {
				// finish button
				if(self.winner) {
					self.monsterBattle[0] = {
						id : null
					};
					self.monsterBattle[1] = {
						id : null
					};
					self.winner = null;
				}else {
					MonsterService.fightMonster(self.monsterBattle).then(function (d) {
						self.winner = d
					}, function (errResponse) {
						console.error('Error while fetching Monsters');
					});
				}
			};

			self.instructions = function(){
				if(self.monsterBattle[0].id == null){
					return 'SELECT FIRST MONSTER';
				}
				if(self.monsterBattle[1].id == null){
					return 'SELECT SECOND MONSTER'
				}
				if(self.monsterBattle[1].id != null && self.monsterBattle[0] != null && self.winner == null){
					return 'READY TO FIGHT'
				}
				if(self.winner != null){
					return 'THE WINNER IS '+ self.winner.monstername;
				}
			}


		} ]);
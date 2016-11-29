<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<title>Monster Battle</title>
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<link href="<c:url value='/static/css/app.css' />" rel="stylesheet">
	
</head>
<body ng-app="myApp" class="ng-cloak" ng-controller="MonsterController as ctrl" ng-class="(ctrl.battleMode)?'battle_bg_color_red':'bg_register_form'">

        <!--- wrap --->
        <div class="generic-container my_form_margin_center">

            <!-- battle Mode Button -->
            <div class="row">
                <div class="form-actions floatRight">
                    <button type="button" class="btn btn-danger btn-sm" ng-click ="ctrl.battleMode = !ctrl.battleMode ">{{ctrl.battleMode? 'Register Form':'Battle Mode'}}</button>
                </div>
            </div>

          <!-- select monster -->
            <div class="panel panel-default" ng-hide="!ctrl.battleMode">

                <!-- instruction -->
                <div class="panel-heading battle_instruction battle_bg_color_softred">
                    <span ng-bind="ctrl.instructions()"> </span>
                </div>

                <div class="panel-heading">
                    <span class="lead">Select Monster Form </span>
                </div>
                    <div class="formcontainer">

                        <form ng-submit="ctrl.submit()" name="selectMonsterForm" class="form-horizontal">

                            <!-- First Monster -->
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label class="col-md-2 control-lable" for="monster1">First Monster</label>
                                    <div class="col-md-7">
                                        <input type="text" ng-model="ctrl.monsterBattle[0].monstername" class="form-control input-sm" disabled required/>
                                    </div>
                                </div>
                            </div>

                            <!-- Second Monster -->
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label class="col-md-2 control-lable" for="monster2">Second Monster</label>
                                    <div class="col-md-7">
                                        <input type="text" ng-model="ctrl.monsterBattle[1].monstername" class="form-control input-sm" disabled required/>
                                    </div>
                                </div>
                            </div>

                            <!--- fight button -->
                            <div class="row">
                                <div class="form-actions button_fight">
                                    <button type="button" class="btn btn-sm button_color_purple button_fight" ng-click ="ctrl.fightMonster()" ng-disabled="selectMonsterForm.$invalid">{{ctrl.winner? 'Finish':'Fight'}}</button>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>


            <!-- form create monster -->
            <div class="panel panel-default" ng-hide="ctrl.battleMode">
                <div class="panel-heading">
                    <span class="lead">Monster Registration Form </span>
                </div>
                    <div class="formcontainer">

                        <form ng-submit="ctrl.submit()" name="myForm" class="form-horizontal">

                            <input type="hidden" ng-model="ctrl.monster.id" />

                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label class="col-md-2 control-lable" for="mname">Name</label>
                                    <div class="col-md-7">
                                        <input type="text" ng-model="ctrl.monster.monstername" name="mname" class="monstername form-control input-sm" placeholder="Enter monster's name" required ng-minlength="3" />
                                        <div class="has-error" ng-show="myForm.mname.$dirty">
                                            <span ng-show="myForm.mname.$error.required">This is a required field</span> <span ng-show="myForm.mname.$error.minlength">Minimum length required is 3</span>
                                            <span ng-show="myForm.mname.$invalid">This field is invalid </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label class="col-md-2 control-lable" for="health">Health</label>
                                    <div class="col-md-7">
                                        <input type="number" ng-model="ctrl.monster.health" name="health" class="health form-control input-sm" placeholder="Enter monster's Health." required min="1"/>
                                        <div class="has-error" ng-show="myForm.health.$dirty">
                                            <span ng-show="myForm.health.$error.required">This is a required field</span> <span ng-show="myForm.health.$error.minlength">Minimum value required is 1</span>
                                            <span ng-show="myForm.health.$invalid">This field is invalid </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label class="col-md-2 control-lable" for="attack">Attack</label>
                                    <div class="col-md-7">
                                        <input type="number" ng-model="ctrl.monster.attack" name="attack"
                                            class="health form-control input-sm"
                                            placeholder="Enter monster's Attack." required min="1"/>
                                        <div class="has-error" ng-show="myForm.attack.$dirty">
                                            <span ng-show="myForm.attack.$error.required">This is a required field</span> <span ng-show="myForm.attack.$error.minlength">Minimum value required is 1</span>
                                            <span ng-show="myForm.attack.$invalid">This field is invalid </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-actions floatRight" ng-hide="ctrl.battleMode">
                                    <input type="submit" value="{{!ctrl.monster.id? 'Add' : 'Update'}}" class="btn btn-primary btn-sm" ng-disabled="myForm.$invalid">
                                    <button type="button" ng-click="ctrl.reset()" class="btn btn-warning btn-sm" ng-disabled="myForm.$pristine">Reset Form</button>
                                </div>
                            </div>

                        </form>
                    </div>
            </div>

            <!-- List monster -->
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading">
                    <span class="lead">List of Monsters </span>
                </div>
                <div class="tablecontainer">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID.</th>
                                <th>Name</th>
                                <th>Health</th>
                                <th>Attack</th>
                                <th width="20%"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="m in ctrl.monsters">
                                <td><span ng-bind="m.id"></span></td>
                                <td><span ng-bind="m.monstername"></span></td>
                                <td><span ng-bind="m.health"></span></td>
                                <td><span ng-bind= "m.attack"></span></td>
                                <td>

                                    <!-- Edit button, Remove Button -->
                                    <div ng-hide="ctrl.battleMode">
                                    <button type="button" ng-click="ctrl.edit(m.id)" class="btn btn-success custom-width">Edit</button>
                                    <button type="button" ng-click="ctrl.remove(m.id)" class="btn btn-danger custom-width">Remove</button>
                                    </div>

                                    <!-- select button -->
                                    <div ng-hide="!ctrl.battleMode" >
                                        <button type="button" ng-click="ctrl.selectedMonster(m)" class="btn custom-width button_color_yellow" ng-disabled="ctrl.isSelected(m.id) || ctrl.winner" >Select</button>
                                        <button type="button" ng-click="ctrl.unselectedMonster(m)" class="btn custom-width button_color_greensea" ng-disabled="!ctrl.isSelected(m.id) || ctrl.winner">UnSelect</button>
                                    </div>

                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>
	<script src="<c:url value='/static/js/app.js' />"></script>
	<script
		src="<c:url value='/static/js/controller/monster_controller.js' />"></script>
	<script
		src="<c:url value='/static/js/service/monster_service.js' />"></script>
</body>
</html>
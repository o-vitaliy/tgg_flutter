import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/containers/h2h/h2h_widget_helper.dart';
import 'package:tgg/models/challenge.dart';
import 'package:tgg/redux_model/app_state.dart';

import '../h2h_actions.dart';

const placeHolder = "modes:head_to_head:home:pin_placeholder";
const prompt = "modes:head_to_head:home:pin_prompt";
const title = "modes:head_to_head:title";
const yourPin = "modes:head_to_head:home:your_pin";
const refresh = "global:refresh";

class H2HInviteContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _H2HInviteContainerState();
}

class _H2HInviteContainerState extends State<H2HInviteContainer> {
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(vm.flavor.get(title), textAlign: TextAlign.center),
              buildSentInviteWidget(vm),
              buildReceivedInviteWidget(vm),
              SizedBox(width: 8, height: 8),
              Text(vm.flavor.get(prompt, params: {"pin": vm.pin}),
                  textAlign: TextAlign.center),
              SizedBox(width: 8, height: 8),
              TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: vm.flavor.get(placeHolder),
                  )),
              SizedBox(width: 8, height: 8),
              RaisedButton(
                child: Text("Invite"),
                onPressed: () => vm.invite(_controller.value.text),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(vm.flavor.get(yourPin, params: {"pin": vm.pin})),
                  SizedBox(width: 8, height: 8),
                  RaisedButton(
                    child: Text(vm.flavor.get(refresh)),
                    onPressed: vm.refresh,
                  )
                ],
              )
            ],
          );
        });
  }

  Widget buildSentInviteWidget(_ViewModel vm) {
    if (vm.challengeSent == null) {
      return SizedBox.shrink();
    } else {
      return buildTeamWidget(
        flavor: vm.flavor,
        text: "modes:head_to_head:home:sent",
        teamName: vm.challengeSent.teamName,
        buttonTitle: "modes:head_to_head:home:resend",
        click: vm.resendInvite,
      );
    }
  }

  Widget buildReceivedInviteWidget(_ViewModel vm) {
    if (vm.challengeReceived == null) {
      return SizedBox.shrink();
    } else {
      return buildTeamWidget(
        flavor: vm.flavor,
        text: "modes:head_to_head:home:received",
        teamName: vm.challengeReceived.teamName,
        buttonTitle: "modes:head_to_head:actions:accept",
        click: () => vm.acceptInvite(true),
        buttonTitle2: "modes:head_to_head:actions:decline",
        click2: () => vm.acceptInvite(false),
      );
    }
  }
}

class _ViewModel {
  final Flavor flavor;
  final String pin;
  final Function(String) invite;
  final Function refresh;
  final Function resendInvite;
  final Function(bool) acceptInvite;
  final Challenge challengeSent;
  final Challenge challengeReceived;

  _ViewModel({
    this.flavor,
    this.pin,
    this.invite,
    this.refresh,
    this.resendInvite,
    this.acceptInvite,
    this.challengeSent,
    this.challengeReceived,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final challengeSent = state.team.getWaitingOpponentToAccept();
    final challengeReceived = state.team.getReceivedInvite();
    final Function(String) invite =
        (opponentPin) => store.dispatch(H2HInviteAction(opponentPin));
    final Function refresh = () => store.dispatch(H2HRefreshAction());
    final Function resendInvite =
        () => store.dispatch(H2HResendInviteAction(challengeSent.teamId));
    final Function(bool) acceptInvite = (accepted) => store
        .dispatch(H2HReactInviteAction(challengeReceived.teamId, accepted));

    return _ViewModel(
      flavor: state.flavor,
      pin: state.team.pin,
      invite: invite,
      refresh: refresh,
      resendInvite: resendInvite,
      acceptInvite: acceptInvite,
      challengeSent: challengeSent,
      challengeReceived: challengeReceived,
    );
  }
}

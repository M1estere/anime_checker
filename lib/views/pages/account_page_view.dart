import 'package:film_checker/views/blocks/account_page/section_block.dart';
import 'package:film_checker/views/pages/settings_page_view.dart';
import 'package:flutter/material.dart';

class CustomUserSection {
  IconData iconData;
  String name;

  CustomUserSection({
    required this.iconData,
    required this.name,
  });
}

class AccountPageView extends StatefulWidget {
  const AccountPageView({super.key});

  @override
  State<AccountPageView> createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView>
    with AutomaticKeepAliveClientMixin<AccountPageView> {
  @override
  bool get wantKeepAlive => true;

  final List<CustomUserSection> _sections = [
    CustomUserSection(iconData: Icons.favorite, name: 'Favourites'),
    CustomUserSection(iconData: Icons.timer, name: 'Planned'),
    CustomUserSection(iconData: Icons.people, name: 'Friends'),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.amber[300]),
          height: MediaQuery.of(context).size.height * .25,
          width: double.infinity,
        ),
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .19),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 55,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 45,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: const Column(
                          children: [
                            FittedBox(
                              child: Text(
                                'M1estere',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            Text(
                              'Since: 21.01.2023',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                height: .7,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SettingsPageView();
                              },
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .5,
                child: GridView.builder(
                    itemCount: _sections.length,
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.4,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2,
                    ),
                    primary: false,
                    itemBuilder: (context, index) => AccountSectionBlock(
                        iconData: _sections[index].iconData,
                        title: _sections[index].name)),
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:currency_converter/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Terms and Conditions", style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            Container(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Text("Last updated: March 13, 2021\n\nPlease read these terms and conditions carefully before using Our Service.",
                  style: TextStyle(color: MyColors.textColor, fontSize: 15, fontWeight: FontWeight.w600)),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Text("Interpretation and Definitions",
                  style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Text("Interpretation", style: TextStyle(color: MyColors.textColor, fontSize: 20, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                  "The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.",
                  style: TextStyle(color: MyColors.textColor, fontSize: 15, fontWeight: FontWeight.w600)),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Text("Definitions", style: TextStyle(color: MyColors.textColor, fontSize: 20, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Text("For the purposes of these Terms and Conditions:",
                  style: TextStyle(color: MyColors.textColor, fontSize: 15, fontWeight: FontWeight.w600)),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Application',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: MyColors.textColor),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  ' means the software program provided by the Company downloaded by You on any electronic device, named Currency Converter App by Currency.Wiki',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Application',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: MyColors.textColor),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  ' Store means the digital distribution service operated and developed by Apple Inc.(Apple App Store) or Google Inc. (Google Play Store) in which the Application has been downloaded.',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Affiliate ',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: MyColors.textColor),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  'means an entity that controls, is controlled by or is under common control with a party, where control means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority. ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Country refers to:',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: MyColors.textColor),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'California, United States ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Company',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: MyColors.textColor),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  '(referred to as either the Company, We, Us or Our in this Agreement) refers to Currency.Wiki, 122 15th st #431 Del Mar, CA 92014. ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Device ',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: MyColors.textColor),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  'means any device that can access the Service such as a computer, a cellphone or a digital tablet. ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'In-app Purchase ',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: MyColors.textColor),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  ' refers to the purchase of a product, item, service or Subscription made through the Application and subject to these Terms and Conditions and/or the Application Stores own terms and conditions. ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Service',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: MyColors.textColor),
                        children: const <TextSpan>[
                          TextSpan(
                              text: ' refers to the Application. ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Subscriptions ',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: MyColors.textColor),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  ' refer to the services or access to the Service offered on a subscription basis by the Company to You.',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: MyColors.textColor),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  ' (also referred as Terms) mean these Terms and Conditions that form the entire agreement between You and the Company regarding the use of the Service.',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Third-party Social Media Service',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: MyColors.textColor),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  ' means any services or content (including data, information, products or services) provided by a third-party that may be displayed, included or made available by the Service.',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'You',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: MyColors.textColor),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  ' means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Acknowledgment",
                  style: TextStyle(
                    color: MyColors.textColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  )),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text: '',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25, color: MyColors.textColor),
                  children: [
                    TextSpan(
                        text:
                            'These are the Terms and Conditions governing the use of this Service and the agreement that operates between You and the Company. These Terms and Conditions set out the rights and obligations of all users regarding the use of the Service.\n\nYour access to and use of the Service is conditioned on Your acceptance of and compliance with these Terms and Conditions. These Terms and Conditions apply to all visitors, users and others who access or use the Service.\n\n',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(
                        text:
                            'By accessing or using the Service You agree to be bound by these Terms and Conditions. If You disagree with any part of these Terms and Conditions then You may not access the Service.\n\n',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(
                        text:
                            'You represent that you are over the age of 18. The Company does not permit those under 18 to use the Service.\n\n',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(
                        text:
                            'Your access to and use of the Service is also conditioned on Your acceptance of and compliance with the Privacy Policy of the Company. Our Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your personal information when You use the Application or the Website and tells You about Your privacy rights and how the law protects You. Please read Our Privacy Policy carefully before using Our Service.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Subscriptions", style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child:
                  Text("Subscription period", style: TextStyle(color: MyColors.textColor, fontSize: 22, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'The Service or some parts of the Service are available only with a paid Subscription. You will be billed in advance on a recurring and periodic basis (such as daily, weekly, monthly or annually), depending on the type of Subscription plan you select when purchasing the Subscription.\n\n',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: MyColors.textColor,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                        text:
                            'At the end of each period, Your Subscription will automatically renew under the exact same conditions unless You cancel it or the Company cancels it.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Subscription cancellations",
                  style: TextStyle(color: MyColors.textColor, fontSize: 22, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'You may cancel Your Subscription renewal either through Your Account settings page or by contacting the Company. You will not receive a refund for the fees You already paid for Your current Subscription period and You will be able to access the Service until the end of Your current Subscription period.\n\n',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: MyColors.textColor,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                        text:
                            'If the Subscription has been made through an In-app Purchase, You can cancel the renewal of Your Subscription with the Application Store.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Billing", style: TextStyle(color: MyColors.textColor, fontSize: 22, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'You shall provide the Company with accurate and complete billing information including full name, address, state, zip code, telephone number, and a valid payment method information.\n\n',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: MyColors.textColor),
                  children: const <TextSpan>[
                    TextSpan(
                        text:
                            'Should automatic billing fail to occur for any reason, the Company will issue an electronic invoice indicating that you must proceed manually, within a certain deadline date, with the full payment corresponding to the billing period as indicated on the invoice.\n\n',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(
                        text:
                            'If the Subscription has been made through an In-app Purchase, all billing is handled by the Application Store and is governed by the Application Stores own terms and conditions.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Fee Changes", style: TextStyle(color: MyColors.textColor, fontSize: 22, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'The Company, in its sole discretion and at any time, may modify the Subscription fees. Any Subscription fee change will become effective at the end of the then-current Subscription period.\n\n',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                  children: const <TextSpan>[
                    TextSpan(
                        text:
                            'The Company will provide You with reasonable prior notice of any change in Subscription fees to give You an opportunity to terminate Your Subscription before such change becomes effective.\n\n',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(
                        text:
                            'Your continued use of the Service after the Subscription fee change comes into effect constitutes Your agreement to pay the modified Subscription fee amount.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Refunds", style: TextStyle(color: MyColors.textColor, fontSize: 22, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text: 'Except when required by law, paid Subscription fees are non-refundable.\n\n',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                  children: const <TextSpan>[
                    TextSpan(
                        text:
                            'Certain refund requests for Subscriptions may be considered by the Company on a case-by-case basis and granted at the sole discretion of the Company..\n\n',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(
                        text:
                            'If the Subscription has been made through an In-app purchase, the Application Stores refund policy will apply. If You wish to request a refund, You may do so by contacting the Application Store directly.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("In-app Purchases", style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                    text:
                        'The Application may include In-app Purchases that allow you to buy products, services or Subscriptions.\n\n',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: MyColors.textColor,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'More information about how you may be able to manage In-app Purchases using your Device may be set out in the Application Stores own terms and conditions or in your Devices Help settings.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'In-app Purchases can only be consumed within the Application. If you make a In-app Purchase, that In-app Purchase cannot be cancelled after you have initiated its download. In-app Purchases cannot be redeemed for cash or other consideration or otherwise transferred.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'If any In-app Purchase is not successfully downloaded or does not work once it has been successfully downloaded, we will, after becoming aware of the fault or being notified to the fault by You, investigate the reason for the fault. We will act reasonably in deciding whether to provide You with a replacement In-app Purchase or issue You with a patch to repair the fault. In no event will We charge You to replace or repair the In-app Purchase. In the unlikely event that we are unable to replace or repair the relevant In-app Purchase or are unable to do so within a reasonable period of time and without significant inconvenience to You, We will authorize the Application Store to refund You an amount up to the cost of the relevant In-app Purchase. Alternatively, if You wish to request a refund, You may do so by contacting the Application Store directly.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'You acknowledge and agree that all billing and transaction processes are handled by the Application Store from where you downloaded the Application and are governed by that Application Stores own terms and conditions.\n\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              'If you have any payment related issues with In-app Purchases, then you need to contact the Application Store directly.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ]),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Links to Other Websites",
                  style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'Our Service may contain links to third-party web sites or services that are not owned or controlled by the Company..\n\n',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                  children: const <TextSpan>[
                    TextSpan(
                        text:
                            'The Company has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third party web sites or services. You further acknowledge and agree that the Company shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with the use of or reliance on any such content, goods or services available on or through any such web sites or services.\n\n',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(
                        text:
                            'We strongly advise You to read the terms and conditions and privacy policies of any third-party web sites or services that You visit.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Termination", style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'We may terminate or suspend Your access immediately, without prior notice or liability, for any reason whatsoever, including without limitation if You breach these Terms and Conditions.\n\n',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                  children: const <TextSpan>[
                    TextSpan(
                        text: 'Upon termination, Your right to use the Service will cease immediately.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Limitation of Liability",
                  style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'Notwithstanding any damages that You might incur, the entire liability of the Company and any of its suppliers under any provision of this Terms and Your exclusive remedy for all of the foregoing shall be limited to the amount actually paid by You through the Service or 100 USD if You havent purchased anything through the Service.\n\n',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                  children: const <TextSpan>[
                    TextSpan(
                        text:
                            'To the maximum extent permitted by applicable law, in no event shall the Company or its suppliers be liable for any special, incidental, indirect, or consequential damages whatsoever (including, but not limited to, damages for loss of profits, loss of data or other information, for business interruption, for personal injury, loss of privacy arising out of or in any way related to the use of or inability to use the Service, third-party software and/or third-party hardware used with the Service, or otherwise in connection with any provision of this Terms), even if the Company or any supplier has been advised of the possibility of such damages and even if the remedy fails of its essential purpose.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(
                        text:
                            'Some states do not allow the exclusion of implied warranties or limitation of liability for incidental or consequential damages, which means that some of the above limitations may not apply. In these states, each partys liability will be limited to the greatest extent permitted by law.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("AS IS and AS AVAILABLE Disclaimer",
                  style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'The Service is provided to You AS IS and AS AVAILABLE and with all faults and defects without warranty of any kind. To the maximum extent permitted under applicable law, the Company, on its own behalf and on behalf of its Affiliates and its and their respective licensors and service providers, expressly disclaims all warranties, whether express, implied, statutory or otherwise, with respect to the Service, including all implied warranties of merchantability, fitness for a particular purpose, title and non-infringement, and warranties that may arise out of course of dealing, course of performance, usage or trade practice. Without limitation to the foregoing, the Company provides no warranty or undertaking, and makes no representation of any kind that the Service will meet Your requirements, achieve any intended results, be compatible or work with any other software, applications, systems or services, operate without interruption, meet any performance or reliability standards or be error free or that any errors or defects can or will be corrected.\n\n',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: MyColors.textColor,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                        text:
                            'Without limiting the foregoing, neither the Company nor any of the companys provider makes any representation or warranty of any kind, express or implied: (i) as to the operation or availability of the Service, or the information, content, and materials or products included thereon; (ii) that the Service will be uninterrupted or error-free; (iii) as to the accuracy, reliability, or currency of any information or content provided through the Service; or (iv) that the Service, its servers, the content, or e-mails sent from or on behalf of the Company are free of viruses, scripts, trojan horses, worms, malware, timebombs or other harmful components.\n\n',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(
                        text:
                            'Some jurisdictions do not allow the exclusion of certain types of warranties or limitations on applicable statutory rights of a consumer, so some or all of the above exclusions and limitations may not apply to You. But in such a case the exclusions and limitations set forth in this section shall be applied to the greatest extent enforceable under applicable law.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Governing Law", style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'The laws of the Country, excluding its conflicts of law rules, shall govern this Terms and Your use of the Service. Your use of the Application may also be subject to other local, state, national, or international laws.',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child:
                  Text("Disputes Resolution", style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'If You have any concern or dispute about the Service, You agree to first try to resolve the dispute informally by contacting the Company.',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 32),
              child: Text("For European Union (EU) Users",
                  style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'TIf You are a European Union consumer, you will benefit from any mandatory provisions of the law of the country in which you are resident in.',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("United States Federal Government End Use Provisions",
                  style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'If You are a U.S. federal government end user, our Service is a Commercial Item as that term is defined at 48 C.F.R. §2.101.',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("United States Legal Compliance",
                  style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'You represent and warrant that (i) You are not located in a country that is subject to the United States government embargo, or that has been designated by the United States government as a terrorist supporting country, and (ii) You are not listed on any United States government list of prohibited or restricted parties.',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Severability and Waiver",
                  style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text: 'Severability\n\n',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 22),
                  children: const <TextSpan>[
                    TextSpan(
                        text:
                            'If any provision of these Terms is held to be unenforceable or invalid, such provision will be changed and interpreted to accomplish the objectives of such provision to the greatest extent possible under applicable law and the remaining provisions will continue in full force and effect.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(" Waiver", style: TextStyle(color: MyColors.textColor, fontSize: 22, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                    text:
                        'Except as provided herein, the failure to exercise a right or to require performance of an obligation under this Terms shall not effect a partys ability to exercise such right or require such performance at any time thereafter nor shall be the waiver of a breach constitute a waiver of any subsequent breach.',
                    style: TextStyle(color: MyColors.textColor, fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Translation Interpretation",
                  style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'These Terms and Conditions may have been translated if We have made them available to You on our Service. You agree that the original English text shall prevail in the case of a dispute.',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Changes to These Terms and Conditions",
                  style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'We reserve the right, at Our sole discretion, to modify or replace these Terms at any time. If a revision is material We will make reasonable efforts to provide at least 30 days notice prior to any new terms taking effect. What constitutes a material change will be determined at Our sole discretion.\n\n',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                  children: const <TextSpan>[
                    TextSpan(
                        text:
                            'By continuing to access or use Our Service after those revisions become effective, You agree to be bound by the revised terms. If You do not agree to the new terms, in whole or in part, please stop using the website and the Service.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Disclaimer", style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text:
                      'Currency.wiki exchange rates are for informational purposes only. Please verify/confirm currency rates with your forex broker or financial institution before making international money transfers and transactions.e.',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Credits", style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text: 'We want to thank the following authors for creating free icons and free license to use charts.\n',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\u2022 ",
                  style: TextStyle(fontSize: 20, color: MyColors.textColor),
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'MD Badsha',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: MyColors.textColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 0.0, top: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Meah:',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: MyColors.textColor),
                        ),
                      ),
                      GestureDetector(
                          onTap: _launchURL,
                          child: Text('https://freeicons.io/profile/3335',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.indigo)))
                    ],
                  )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Text(
                    "icon king1:",
                    style: TextStyle(fontSize: 15, color: MyColors.textColor, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                      onTap: _launchURL1,
                      child: const Text(
                        'https://freeicons.io/profile/3',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.indigo),
                      ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 0.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Text(
                    "Freepik:",
                    style: TextStyle(fontSize: 15, color: MyColors.textColor, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: _launchURL3,
                        child: Text(
                          'https://www.flaticon.com ',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.indigo),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 0.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "        &",
                    style: TextStyle(fontSize: 15, color: MyColors.textColor, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: _launchURL4,
                        child: Text(
                          ' https://www.freepik.com',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.indigo),
                        )),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 0.00,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(fontSize: 18, color: MyColors.textColor),
                  ),
                  Text(
                    "amCharts:",
                    style: TextStyle(fontSize: 15, color: MyColors.textColor, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: _launchURL5,
                        child: Text(
                          ' https://www.amcharts.com/',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.indigo),
                        )),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Contact Us", style: TextStyle(color: MyColors.textColor, fontSize: 25, fontWeight: FontWeight.w900)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text: 'If you have any questions about these Terms and Conditions, You can contact us:.\n',
                  style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.textColor, fontSize: 15),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, bottom: 50),
              child: RichText(
                text: TextSpan(
                  text: 'By email: info@currency.wiki',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: MyColors.textColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://freeicons.io/profile/3335';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL1() async {
    const url = 'https://freeicons.io/profile/3';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL3() async {
    const url = 'https://www.flaticon.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL4() async {
    const url = 'https://www.freepik.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL5() async {
    const url = 'https://www.amcharts.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

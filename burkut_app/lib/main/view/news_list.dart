import 'package:burkut_app/constants/app/app_text_styles.dart';
import 'package:burkut_app/main/view/new_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsListView extends StatefulWidget {
  const NewsListView({Key? key}) : super(key: key);

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset('assets/icons/logo.png'),
        ),
        title: Text(
          'Маалыматтар',
          style: AppTextStyles.black16,
        ),
        elevation: 1,
      ),
      body: _buildNewsList(),
    );
  }

  Widget _buildNewsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('news').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No news available.'));
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Card(
              margin: const EdgeInsets.all(20),
              child: ListTile(
                contentPadding: const EdgeInsets.all(7),
                title: Text(
                  data['title'],
                  style: AppTextStyles.main18,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data['created_at'].toDate().toString(),
                    style: AppTextStyles.black14,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailPage(news: data),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

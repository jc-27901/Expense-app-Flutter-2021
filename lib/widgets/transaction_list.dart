import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx,constraints){
          return Column(
            children: [
              Text(
                'No Transaction added yet!',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  )),
            ],
          );
    })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5.0,
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text('\$ ${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width >460 ?
                      FlatButton.icon(
                        icon: (Icon(Icons.delete)),
                        textColor: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[index].id),
                        label: Text('Delete'),
                      )
                      : IconButton(
                      icon: (Icon(Icons.delete)),
                      color: Theme.of(context).errorColor,
                      onPressed: (){
                        return deleteTx(transactions[index].id);
                      },
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}

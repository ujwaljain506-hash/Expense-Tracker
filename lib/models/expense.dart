enum Category { food,travel,bills,shopping,other}

class Expense{
    final String id;
    final String title;
    final double amount;
    final Category category;
    final DateTime date;

    Expense({
        required this.id,
        required this.title,
        required this.amount,
        required this.category,
        required this.date,
    });
}
class ApiData {
  String? txnDate;
  int? newCase;
  int? totalCase;
  int? newCaseExcludeabroad;
  int? totalCaseExcludeabroad;
  int? newDeath;
  int? totalDeath;
  int? newRecovered;
  int? totalRecovered;
  String? updateDate;

  ApiData(
      {this.txnDate,
      this.newCase,
      this.totalCase,
      this.newCaseExcludeabroad,
      this.totalCaseExcludeabroad,
      this.newDeath,
      this.totalDeath,
      this.newRecovered,
      this.totalRecovered,
      this.updateDate});

  ApiData.fromJson(Map<String, dynamic> json) {
    txnDate = json['txn_date'];
    newCase = json['new_case'];
    totalCase = json['total_case'];
    newCaseExcludeabroad = json['new_case_excludeabroad'];
    totalCaseExcludeabroad = json['total_case_excludeabroad'];
    newDeath = json['new_death'];
    totalDeath = json['total_death'];
    newRecovered = json['new_recovered'];
    totalRecovered = json['total_recovered'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txn_date'] = this.txnDate;
    data['new_case'] = this.newCase;
    data['total_case'] = this.totalCase;
    data['new_case_excludeabroad'] = this.newCaseExcludeabroad;
    data['total_case_excludeabroad'] = this.totalCaseExcludeabroad;
    data['new_death'] = this.newDeath;
    data['total_death'] = this.totalDeath;
    data['new_recovered'] = this.newRecovered;
    data['total_recovered'] = this.totalRecovered;
    data['update_date'] = this.updateDate;
    return data;
  }
}

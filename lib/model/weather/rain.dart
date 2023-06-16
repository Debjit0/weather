class Rain {
	double? oneh;

	Rain({this.oneh});

	factory Rain.fromJson(Map<String, dynamic> json) => Rain(
				oneh: (json['1h'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toJson() => {
				'oneh': oneh,
			};
}

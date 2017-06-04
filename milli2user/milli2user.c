#include <stdio.h>

#define MIL_IN_SEC 1000
#define SEC_IN_MIN 60
#define MIN_IN_HR 60
#define HR_IN_DAY 24

int main(int argc, char ** argv) {
	if (argc != 2) {
		return -1;
	}

	long int milliseconds = atoi(argv[1]);

	long int seconds = milliseconds / MIL_IN_SEC;
	long int minutes = seconds / SEC_IN_MIN;
	long int hours = minutes / MIN_IN_HR;
	long int days = hours / HR_IN_DAY;

	if (days) {
		printf("%dd ", days);
	}

	if (hours) {
		printf("%dh ", hours % HR_IN_DAY);
	}

	if (minutes) {
		printf("%dm ", minutes % MIN_IN_HR);
	}

	if (seconds) {
		printf("%d.", seconds % SEC_IN_MIN);
	}

	if (milliseconds) {
		if (seconds) {
			printf("%03ds", milliseconds % MIL_IN_SEC);
		} else {
			printf("%dms", milliseconds % MIL_IN_SEC);
		}
	}

	return 0;
}
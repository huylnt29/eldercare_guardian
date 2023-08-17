part of '../related_report_info_screen.dart';

class ViewFinishedReportsTab extends StatelessWidget {
  const ViewFinishedReportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        if (state.reportsLoadState == LoadState.loading) {
          return const ListViewShimmer();
        } else if (state.reportsLoadState == LoadState.error) {
          return const AppErrorWidget();
        } else if (state.reportsLoadState == LoadState.loaded) {
          return buildLoadedContent(context, state.reports);
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildLoadedContent(BuildContext context, List<Report> reports) {
    return (reports.isEmpty)
        ? const NoDataWidget()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: reports.length,
            itemBuilder: (context, index) => buildFinishedReportItem(
              context,
              reports[index],
            ),
          );
  }

  Widget buildFinishedReportItem(BuildContext context, Report report) {
    final reportBloc = context.read<ReportBloc>();
    return RoundedContainerWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.aipId ?? ErrorMessage.isNotDetermined,
                  style: AppTextStyles.heading3(AppColors.textColor),
                ),
                12.vertical,
                Text(
                  report.summary ?? ErrorMessage.isNotDetermined,
                  style: AppTextStyles.smallText(AppColors.textColor),
                ),
              ],
            ),
          ),
          18.hSpace,
          IconButton(
            onPressed: () => Routes.router.navigateTo(
              context,
              RoutePath.reportDetailsScreen,
              routeSettings: RouteSettings(
                arguments: {'report': report},
              ),
            ),
            icon: Assets.icons.arrowLeft.svg(
              width: 48.sf,
              color: AppColors.accentColor,
            ),
          )
        ],
      ),
    );
  }
}

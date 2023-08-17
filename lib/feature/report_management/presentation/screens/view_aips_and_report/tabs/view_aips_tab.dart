part of '../related_report_info_screen.dart';

class ViewAipsTab extends StatelessWidget {
  const ViewAipsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        if (state.aipsLoadState == LoadState.loading) {
          return const ListViewShimmer();
        } else if (state.aipsLoadState == LoadState.error) {
          return const AppErrorWidget();
        } else if (state.aipsLoadState == LoadState.loaded) {
          return buildLoadedContent(context, state.aips);
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildLoadedContent(BuildContext context, List<Aip?> aips) {
    return (aips.isEmpty)
        ? const NoDataWidget()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: aips.length,
            itemBuilder: (context, index) => buildAipReportItem(
              context,
              aips[index]!,
            ),
          );
  }

  Widget buildAipReportItem(BuildContext context, Aip aip) {
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
                  aip.lastName,
                  style: AppTextStyles.heading3(AppColors.textColor),
                ),
                12.vertical,
                Text(
                  aip.address,
                  style: AppTextStyles.smallText(AppColors.textColor),
                ),
              ],
            ),
          ),
          18.hSpace,
          IconButton(
            onPressed: () async {
              final result = await Routes.router.navigateTo(
                context,
                RoutePath.reportDetailsScreen,
                routeSettings: RouteSettings(
                  arguments: {'aip': aip},
                ),
              );
              if (result == true) {
                reportBloc.add(GetAipsEvent());
              }
            },
            icon: Assets.icons.writeReport.svg(
              width: 48.sf,
              color: AppColors.accentColor,
            ),
          )
        ],
      ),
    );
  }
}

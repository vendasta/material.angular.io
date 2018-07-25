import {NgModule} from '@angular/core';
import {UIKitModule} from '@vendasta/uikit';

import {VaIconOverviewExample} from './va-icon-overview/va-icon-overview-example';

@NgModule({
  declarations: [VaIconOverviewExample],
  imports: [UIKitModule],
  exports: [VaIconOverviewExample],
  entryComponents: [VaIconOverviewExample]
})
export class VendastaExampleModule {}

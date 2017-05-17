import { ZuadaPage } from './app.po';

describe('zuada App', () => {
  let page: ZuadaPage;

  beforeEach(() => {
    page = new ZuadaPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/market_summary.dart';
import '../../models/orderbook.dart';
import '../../utils/formatters.dart';
import '../../config/theme.dart';

class OrderScreen extends StatefulWidget {
  final MarketSummary instrument;
  final bool? initialIsBuy;

  const OrderScreen({super.key, required this.instrument, this.initialIsBuy});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // Order type: true = Buy, false = Sell
  bool _isBuyOrder = true;

  // Form controllers
  final _quantityController = TextEditingController();
  final _limitPriceController = TextEditingController();

  // Form values
  String _selectedCompte = 'Compte 1';
  String _selectedOrderType = 'Limite';
  String _selectedValidity = 'Jour';
  DateTime? _expirationDate;

  // Validation errors
  String? _quantityError;
  String? _priceError;

  // Mock orderbook data (first entry)
  MarketOrderBook? _bestBid;
  MarketOrderBook? _bestAsk;

  // Mock client info
  final double _montantDispo = 50000.0;
  final double _qtyDispo = 100.0;

  final List<String> _comptes = ['Compte 1', 'Compte 2', 'Compte 3'];
  final List<String> _orderTypes = ['Limite', 'Marché', 'Stop'];
  final List<String> _validities = ['Jour', 'GTC', 'GTD'];

  @override
  void initState() {
    super.initState();
    _isBuyOrder = widget.initialIsBuy ?? true;
    _loadOrderbookData();
    _limitPriceController.text = widget.instrument.price?.toStringAsFixed(2) ?? '';
  }

  void _loadOrderbookData() {
    // Mock orderbook data - first entry for bid and ask
    _bestBid = MarketOrderBook(
      secId: widget.instrument.secId,
      symbol: widget.instrument.symbol,
      side: 'BID',
      price: widget.instrument.price != null ? widget.instrument.price! - 0.5 : 0,
      quantity: 1500,
      dateOrder: DateTime.now(),
    );

    _bestAsk = MarketOrderBook(
      secId: widget.instrument.secId,
      symbol: widget.instrument.symbol,
      side: 'ASK',
      price: widget.instrument.price != null ? widget.instrument.price! + 0.5 : 0,
      quantity: 2000,
      dateOrder: DateTime.now(),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _limitPriceController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    // Reset errors
    setState(() {
      _quantityError = null;
      _priceError = null;
    });

    bool hasError = false;

    // Validate quantity
    if (_quantityController.text.isEmpty) {
      setState(() => _quantityError = 'Quantité requise');
      hasError = true;
    } else {
      final qty = double.tryParse(_quantityController.text);
      if (qty == null || qty <= 0) {
        setState(() => _quantityError = 'Quantité invalide');
        hasError = true;
      }
    }

    // Validate price for Limite and Stop orders
    if (_selectedOrderType == 'Limite' || _selectedOrderType == 'Stop') {
      if (_limitPriceController.text.isEmpty) {
        setState(() => _priceError = 'Prix requis');
        hasError = true;
      } else {
        final price = double.tryParse(_limitPriceController.text);
        if (price == null || price <= 0) {
          setState(() => _priceError = 'Prix invalide');
          hasError = true;
        }
      }
    }

    if (!hasError) {
      _showConfirmationDialog();
    }
  }

  void _validateQuantity(String value) {
    if (value.isEmpty) {
      setState(() => _quantityError = 'Quantité requise');
    } else {
      final qty = double.tryParse(value);
      if (qty == null || qty <= 0) {
        setState(() => _quantityError = 'Quantité invalide');
      } else {
        setState(() => _quantityError = null);
      }
    }
  }

  void _validatePrice(String value) {
    if (_selectedOrderType == 'Limite' || _selectedOrderType == 'Stop') {
      if (value.isEmpty) {
        setState(() => _priceError = 'Prix requis');
      } else {
        final price = double.tryParse(value);
        if (price == null || price <= 0) {
          setState(() => _priceError = 'Prix invalide');
        } else {
          setState(() => _priceError = null);
        }
      }
    } else {
      setState(() => _priceError = null);
    }
  }

  void _showConfirmationDialog() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final quantity = double.tryParse(_quantityController.text) ?? 0;
    final price = _selectedOrderType == 'Limite'
        ? (double.tryParse(_limitPriceController.text) ?? 0)
        : widget.instrument.price ?? 0;
    final total = quantity * price;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        title: Text('Confirmer l\'ordre', style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${_isBuyOrder ? "Achat" : "Vente"} de ${widget.instrument.symbol}', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text('Quantité: ${_quantityController.text}'),
            Text('Prix: ${Formatters.formatNumber(price)}'),
            Text('Total: ${Formatters.formatCurrency(total)}'),
            Text('Type: $_selectedOrderType'),
            Text('Validité: $_selectedValidity'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          ElevatedButton(onPressed: () { Navigator.pop(context); _showSuccessDialog(); }, child: const Text('Confirmer')),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Succès'),
        content: const Text('Votre ordre a été soumis avec succès'),
        actions: [
          TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Text('${widget.instrument.symbol ?? ""}', style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 16, fontWeight: FontWeight.w700)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: (_isBuyOrder ? AppColors.success : AppColors.error).withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _isBuyOrder ? AppColors.success : AppColors.error),
              ),
              child: Text(_isBuyOrder ? 'ACHAT' : 'VENTE', style: TextStyle(color: _isBuyOrder ? AppColors.success : AppColors.error, fontSize: 12, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildCompactInstrumentHeader(isDarkMode),
                  const SizedBox(height: 16),
                  _buildOrderbookCompact(isDarkMode),
                  const SizedBox(height: 20),
                  _buildOrderDetailsSection(isDarkMode),
                  const SizedBox(height: 16),
                  _buildSummarySection(isDarkMode),
                ],
              ),
            ),
          ),
          _buildBottomActions(isDarkMode),
        ],
      ),
    );
  }

  Widget _buildBuySellToggle(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _isBuyOrder = true),
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: _isBuyOrder ? AppColors.success : Colors.transparent,
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_upward_rounded, color: _isBuyOrder ? Colors.white : AppColors.success, size: 20),
                    const SizedBox(width: 8),
                    Text('Acheter', style: TextStyle(color: _isBuyOrder ? Colors.white : (isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight), fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _isBuyOrder = false),
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: !_isBuyOrder ? AppColors.error : Colors.transparent,
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_downward_rounded, color: !_isBuyOrder ? Colors.white : AppColors.error, size: 20),
                    const SizedBox(width: 8),
                    Text('Vendre', style: TextStyle(color: !_isBuyOrder ? Colors.white : (isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight), fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstrumentInfo(bool isDarkMode) {
    final variation = widget.instrument.variation ?? 0;
    final isPositive = variation >= 0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Instrument', style: TextStyle(color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text(widget.instrument.symbol?.substring(0, 1) ?? '?', style: const TextStyle(color: AppColors.primary, fontSize: 20, fontWeight: FontWeight.w700))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.instrument.symbol ?? 'N/A', style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(widget.instrument.name ?? 'N/A', style: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(Formatters.formatNumber(widget.instrument.price ?? 0), style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: (isPositive ? AppColors.success : AppColors.error).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                    child: Text(Formatters.formatPercent(variation), style: TextStyle(color: isPositive ? AppColors.success : AppColors.error, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderbookEntry(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Carnet d\'ordres', style: TextStyle(color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildOrderbookSide('Meilleure offre (Bid)', _bestBid?.price ?? 0, _bestBid?.quantity ?? 0, AppColors.success, isDarkMode)),
              const SizedBox(width: 12),
              Expanded(child: _buildOrderbookSide('Meilleure demande (Ask)', _bestAsk?.price ?? 0, _bestAsk?.quantity ?? 0, AppColors.error, isDarkMode)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderbookSide(String label, double price, double quantity, Color color, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight, fontSize: 10, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(Formatters.formatNumber(price), style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('Qty: ${Formatters.formatVolume(quantity)}', style: TextStyle(color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildClientInfo(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Informations client', style: TextStyle(color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildClientInfoItem('Montant disponible', Formatters.formatCurrency(_montantDispo), Icons.account_balance_wallet_rounded, isDarkMode)),
              const SizedBox(width: 12),
              Expanded(child: _buildClientInfoItem('Quantité disponible', '${_qtyDispo.toStringAsFixed(0)} titres', Icons.inventory_2_rounded, isDarkMode)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientInfoItem(String label, String value, IconData icon, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: isDarkMode ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Expanded(child: Text(label, style: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight, fontSize: 10, fontWeight: FontWeight.w500))),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 14, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildOrderForm(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Détails de l\'ordre', style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          _buildDropdownField('Compte', _selectedCompte, _comptes, (value) => setState(() => _selectedCompte = value!), isDarkMode),
          const SizedBox(height: 16),
          _buildTextField('Quantité', _quantityController, TextInputType.number, isDarkMode),
          const SizedBox(height: 16),
          _buildDropdownField('Type d\'ordre', _selectedOrderType, _orderTypes, (value) => setState(() => _selectedOrderType = value!), isDarkMode),
          const SizedBox(height: 16),
          if (_selectedOrderType == 'Limite') ...[
            _buildTextField('Prix limite', _limitPriceController, TextInputType.number, isDarkMode),
            const SizedBox(height: 16),
          ],
          _buildDropdownField('Validité', _selectedValidity, _validities, (value) => setState(() => _selectedValidity = value!), isDarkMode),
          const SizedBox(height: 16),
          if (_selectedValidity == 'GTD') ...[
            _buildDateField(isDarkMode),
            const SizedBox(height: 16),
          ],
          _buildOrderSummary(isDarkMode),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType keyboardType, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
          decoration: InputDecoration(
            hintText: 'Entrer $label',
            hintStyle: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight),
            filled: true,
            fillColor: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          onChanged: (value) => setState(() {}),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> items, Function(String?) onChanged, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 14),
              dropdownColor: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
              items: items.map((String item) => DropdownMenuItem<String>(value: item, child: Text(item))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date d\'expiration', style: TextStyle(color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _expirationDate ?? DateTime.now().add(const Duration(days: 1)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) setState(() => _expirationDate = date);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _expirationDate != null ? DateFormat('dd/MM/yyyy').format(_expirationDate!) : 'Sélectionner une date',
                  style: TextStyle(color: _expirationDate != null ? (isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight) : (isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight), fontSize: 14),
                ),
                Icon(Icons.calendar_today_rounded, size: 18, color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary(bool isDarkMode) {
    final quantity = double.tryParse(_quantityController.text) ?? 0;
    final price = _selectedOrderType == 'Limite' ? (double.tryParse(_limitPriceController.text) ?? 0) : widget.instrument.price ?? 0;
    final total = quantity * price;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.primary.withOpacity(0.2))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Montant estimé', style: TextStyle(color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, fontSize: 12, fontWeight: FontWeight.w500)),
              Text(Formatters.formatCurrency(total), style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 16, fontWeight: FontWeight.w700)),
            ],
          ),
          if (quantity > 0 && price > 0) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Prix unitaire', style: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight, fontSize: 11)),
                Text(Formatters.formatNumber(price), style: TextStyle(color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubmitButton(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitOrder,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isBuyOrder ? AppColors.success : AppColors.error,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          _isBuyOrder ? 'Confirmer l\'achat' : 'Confirmer la vente',
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildCompactInstrumentHeader(bool isDarkMode) {
    final variation = widget.instrument.variation ?? 0;
    final isPositive = variation >= 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.instrument.name ?? widget.instrument.symbol ?? 'N/A', style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(widget.instrument.symbol ?? 'N/A', style: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${Formatters.formatNumber(widget.instrument.price ?? 0)} MAD', style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward, color: isPositive ? AppColors.success : AppColors.error, size: 14),
                      Text(Formatters.formatPercent(variation.abs()), style: TextStyle(color: isPositive ? AppColors.success : AppColors.error, fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildInfoItem('Ouverture', Formatters.formatNumber(widget.instrument.openingPrice ?? 0), isDarkMode)),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoItem('Plus haut', Formatters.formatNumber(widget.instrument.higherPrice ?? 0), isDarkMode)),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoItem('Plus bas', Formatters.formatNumber(widget.instrument.lowerPrice ?? 0), isDarkMode)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight, fontSize: 10)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildOrderbookCompact(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('1ère limite', style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildOrderbookColumn('Qté', (_bestBid?.quantity ?? 0).toStringAsFixed(0), isDarkMode)),
              Expanded(child: _buildOrderbookColumn('Demande', Formatters.formatNumber(_bestBid?.price ?? 0), isDarkMode)),
              Expanded(child: _buildOrderbookColumn('Offre', Formatters.formatNumber(_bestAsk?.price ?? 0), isDarkMode)),
              Expanded(child: _buildOrderbookColumn('Qté', (_bestAsk?.quantity ?? 0).toStringAsFixed(0), isDarkMode)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderbookColumn(String label, String value, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight, fontSize: 10)),
        const SizedBox(height: 6),
        Text(value, style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildOrderDetailsSection(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Détails de l\'ordre', style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildCompactDropdown('Compte', _selectedCompte, _comptes, (v) => setState(() => _selectedCompte = v!), isDarkMode)),
            const SizedBox(width: 12),
            Expanded(child: _buildCompactTextField('Quantité', _quantityController, isDarkMode)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildCompactDropdown('Type d\'ordre', _selectedOrderType, _orderTypes, (v) {
              setState(() {
                _selectedOrderType = v!;
                if (_selectedOrderType == 'Marché') {
                  _priceError = null;
                }
              });
            }, isDarkMode)),
            const SizedBox(width: 12),
            if (_selectedOrderType == 'Limite' || _selectedOrderType == 'Stop')
              Expanded(child: _buildCompactTextField('Prix limite', _limitPriceController, isDarkMode, suffix: 'MAD'))
            else
              const Expanded(child: SizedBox()),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildCompactDropdown('Validité', _selectedValidity, _validities, (v) => setState(() => _selectedValidity = v!), isDarkMode)),
            const SizedBox(width: 12),
            if (_selectedValidity == 'GTD')
              Expanded(child: _buildCompactDateField(isDarkMode))
            else
              const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildCompactTextField(String label, TextEditingController controller, bool isDarkMode, {String? suffix}) {
    final isQuantityField = controller == _quantityController;
    final isPriceField = controller == _limitPriceController;
    final errorText = isQuantityField ? _quantityError : (isPriceField ? _priceError : null);
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight, fontSize: 11)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hasError 
                ? AppColors.error 
                : (isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
              width: hasError ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 14, fontWeight: FontWeight.w600),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {
                    if (isQuantityField) {
                      _validateQuantity(v);
                    } else if (isPriceField) {
                      _validatePrice(v);
                    }
                    setState(() {});
                  },
                ),
              ),
              if (suffix != null) ...[
                const SizedBox(width: 8),
                Text(suffix, style: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight, fontSize: 12)),
              ],
            ],
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            errorText,
            style: const TextStyle(color: AppColors.error, fontSize: 10, fontWeight: FontWeight.w500),
          ),
        ],
      ],
    );
  }

  Widget _buildCompactDropdown(String label, String value, List<String> items, Function(String?) onChanged, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight, fontSize: 11)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              isDense: true,
              icon: Icon(Icons.keyboard_arrow_down, size: 18, color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight),
              style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 14, fontWeight: FontWeight.w600),
              dropdownColor: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
              items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactDateField(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date d\'expiration', style: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight, fontSize: 11)),
        const SizedBox(height: 6),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _expirationDate ?? DateTime.now().add(const Duration(days: 1)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) setState(() => _expirationDate = date);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _expirationDate != null ? DateFormat('yyyy-MM-dd').format(_expirationDate!) : '2025-09-13',
                  style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Icon(Icons.calendar_today, size: 16, color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(bool isDarkMode) {
    final quantity = double.tryParse(_quantityController.text) ?? 0;
    final price = _selectedOrderType == 'Limite' ? (double.tryParse(_limitPriceController.text) ?? 0) : widget.instrument.price ?? 0;
    final total = quantity * price;
    final montantDispo = _montantDispo;
    final qtyDispo = _qtyDispo;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('Montant', Formatters.formatNumber(total), isDarkMode),
          _buildSummaryItem('Quantité\ndisponible', qtyDispo.toStringAsFixed(0), isDarkMode),
          _buildSummaryItem('Montant\ndisponible', Formatters.formatNumber(montantDispo), isDarkMode),
          _buildSummaryItem('Valeur\nengagée', total > 0 ? '-${Formatters.formatNumber(total)}' : '0.00', isDarkMode, isNegative: total > 0),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, bool isDarkMode, {bool isNegative = false}) {
    return Column(
      children: [
        Text(label, textAlign: TextAlign.center, style: TextStyle(color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiaryLight, fontSize: 10, height: 1.3)),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: isNegative ? AppColors.error : (isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        border: Border(top: BorderSide(color: isDarkMode ? Colors.white.withOpacity(0.1) : AppColors.borderLight)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => setState(() => _isBuyOrder = !_isBuyOrder),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: _isBuyOrder ? AppColors.error : AppColors.success),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                _isBuyOrder ? 'Vendre' : 'Acheter',
                style: TextStyle(color: _isBuyOrder ? AppColors.error : AppColors.success, fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _submitOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isBuyOrder ? AppColors.success : AppColors.error,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Passer l\'ordre ${_isBuyOrder ? "d\'achat" : "de vente"}',
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
